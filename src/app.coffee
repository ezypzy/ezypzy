# Load dependencies ------
express  = require("express")
app      = module.exports = express.createServer()
router   = require("./lib/router")
conf     = require("./config/global.conf")

# -----

# Flatiron CLI (command line interface) plugin ==============================================

# app.use flatiron.plugins.cli,

#   dir   : path.join(__dirname,'lib','commands')
#   usage : "Snap.Sell.Share; Server is listening on port " + conf.port

# ===========================================================================================


# Express configuration settings -----
app.configure ->
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser()
  app.use express.session({ secret : "ezypzy", key : "express.sid" })
  app.use express.errorHandler({ showStack: true, dumpExceptions: true })

  app.use app.router
  app.use express.static(__dirname + "/public")
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
# -----

# process.addListener "uncaughtException", (err) ->
#   util.log("Uncaught exception: " + err.stack)
#   console.trace()

router.routes()

# Initialise the app ========================================================================
unless module.parent

  # Router ------
  app.listen conf.port
  # -------

  # Start ------
  #app.start()
    # -----

  console.log "Server listening on port %d", app.address().port

# ===========================================================================================
