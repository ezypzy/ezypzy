# Load dependencies ------
flatiron    = require("flatiron")
path        = require("path")
director    = require("./lib/router")
conf        = require("./config/global.conf")
app         = flatiron.app
# -----

# Flatiron CLI (command line interface) plugin ==============================================

app.use flatiron.plugins.cli,

  dir   : path.join(__dirname,'lib','commands')
  usage : "Snap.Sell.Share; Server is listening on port " + conf.port

# ===========================================================================================


# Initialise the app ========================================================================

if require.main is module

  app.init ->
    # Router ------
    director.listen conf.port
    # -------

    # Start ------
    app.start()
    # -----

# ===========================================================================================
