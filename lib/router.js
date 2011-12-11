var app, conf, cradle, db, fs, routes, util;

util = require("util");

app = require("../app");

cradle = require("cradle");

fs = require("fs");

conf = require("../config/global.conf");

db = new cradle.Connection('http://localhost', 5984, {
  cache: true,
  raw: false
}).database("ezypzy");

routes = function() {
  app.get("/", function(req, res) {
    var data;
    data = {
      loggedIn: false
    };
    if (req.session.loggedIn === true) {
      data = {
        loggedIn: true
      };
    }
    return res.render("index", data);
  });
  app.get("/register", function(req, res) {
    return res.render("register");
  });
  app.post("/register", function(req, res) {
    var email, name;
    name = req.body.name;
    email = req.body.email;
    return db.save("users", {
      name: name,
      email: email
    }, function(err, result) {
      if (err) {
        return console.log(err);
      } else {
        return res.redirect("/");
      }
    });
  });
  app.get("/login", function(req, res) {
    return res.render("login");
  });
  app.post("/login", function(req, res) {
    var email, name;
    name = req.body.name;
    email = req.body.email;
    return db.get("users", function(err, doc) {
      if (name === doc.name && email === doc.email) {
        req.session.loggedIn = true;
        return res.redirect("/");
      } else {
        res.send("Failed");
        return setTimeout(function() {
          return res.redirect("/");
        }, 3000);
      }
    });
  });
  app.get("/feeds", function(req, res) {
    return db.all(function(err, doc) {
      var d, data, _i, _len;
      data = [];
      for (_i = 0, _len = doc.length; _i < _len; _i++) {
        d = doc[_i];
        if (/items/.test(d.id) === true) {
          db.get(d.id, function(err, res) {
            var dd;
            dd = {
              name: res.description,
              path: res.image,
              price: res.price
            };
            return data.push(dd);
          });
        }
      }
      return process.nextTick(function() {
        return res.render("feeds", {
          data: data
        });
      });
    });
  });
  app.get("/sell", function(req, res) {
    return res.render("sell");
  });
  app.post("/sell", function(req, res, next) {
    var desc, image, ins, ous, price, src;
    image = req.body.image;
    desc = req.body.description;
    price = req.body.price;
    ins = fs.createReadStream(req.files.image.path);
    ous = fs.createWriteStream("" + (process.cwd()) + "/public/images/items/" + req.files.image.filename);
    src = "/images/items/" + req.files.image.filename;
    return util.pump(ins, ous, function(err) {
      if (err) {
        return next(err);
      } else {
        return db.save("items" + Math.random(), {
          description: desc,
          image: src,
          price: price
        }, function(err, result) {
          if (err) {
            return console.log(err);
          } else {
            return res.redirect("/feeds");
          }
        });
      }
    });
  });
  return app.get("/buy", function(req, res) {
    return res.render("buy");
  });
};

module.exports = {
  routes: routes
};
