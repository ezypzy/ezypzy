flatiron = require("flatiron")
path     = require("path")
director = require("./lib/director")
conf     = require("./config/global.conf")
app      = flatiron.app


app.use flatiron.plugins.cli,

  dir   : path.join(__dirname,'lib','commands')
  usage : "Snap.Sell.Share; Server is listening on port " + conf.port


if require.main is module

  app.init ->
    director.listen conf.port
    app.start()
