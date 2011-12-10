var app, conf, express, router;

express = require("express");

app = module.exports = express.createServer();

router = require("./lib/router");

conf = require("./config/global.conf");

app.configure(function() {
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.cookieParser());
  app.use(express.session({
    secret: "ezypzy",
    key: "express.sid"
  }));
  app.use(express.errorHandler({
    showStack: true,
    dumpExceptions: true
  }));
  app.use(app.router);
  app.use(express.static(__dirname + "/public"));
  app.set("views", __dirname + "/views");
  return app.set("view engine", "jade");
});

router.routes();

if (!module.parent) {
  app.listen(conf.port);
  console.log("Server listening on port %d", app.address().port);
}
