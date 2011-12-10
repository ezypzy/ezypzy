var app, conf, director, flatiron, path;

flatiron = require("flatiron");

path = require("path");

director = require("./lib/router");

conf = require("./config/global.conf");

app = flatiron.app;

app.use(flatiron.plugins.cli, {
  dir: path.join(__dirname, 'lib', 'commands'),
  usage: "Snap.Sell.Share; Server is listening on port " + conf.port
});

if (require.main === module) {
  app.init(function() {
    director.listen(conf.port);
    return app.start();
  });
}
