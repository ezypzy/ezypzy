var app, conf, cradle, db, fs, routes;

app = require("../app");

cradle = require("cradle");

fs = require("fs");

conf = require("../config/global.conf");

db = new cradle.Connection().database("ezypzy");

routes = function() {
  app.get("/", function(req, res) {
    return res.render("index");
  });
  app.get("/register", function(req, res) {
    return res.render("register");
  });
  app.post("/register", function(req, res) {
    var email, name;
    name = req.body.name;
    email = req.body.email;
    return db.save("items", {
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
  return app.post("/login", function(req, res) {
    var email, name;
    name = req.body.name;
    email = req.body.email;
    return db.get("items", function(err, doc) {
      if (name === doc.name && email === doc.email) {
        return res.redirect("/");
      } else {
        return res.send("Failed");
      }
    });
  });
};

module.exports = {
  routes: routes
};
