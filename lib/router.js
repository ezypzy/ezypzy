var app, conf, cradle, db, form, fs, routes, util;

app = require("../app");

cradle = require("cradle");

fs = require("fs");

conf = require("../config/global.conf");

form = require("connect-form");

db = new cradle.Connection().database("ezypzy");

util = require("util");

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
    return db.get("items", function(err, doc) {
      console.log(doc);
      return res.render("feeds");
    });
  });
  app.get("/sell", function(req, res) {
    return res.render("sell");
  });
  return app.post("/sell", function(req, res, next) {
    var desc, image, ins, ous;
    image = req.body.image;
    desc = req.body.description;
    ins = fs.createReadStream(req.files.image.path);
    ous = fs.createWriteStream("" + (process.cwd()) + "/public/images/items/" + req.files.image.filename);
    return util.pump(ins, ous, function(err) {
      if (err) {
        return next(err);
      } else {
        return db.save("items", {
          description: desc,
          image: ous
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
};

module.exports = {
  routes: routes
};
