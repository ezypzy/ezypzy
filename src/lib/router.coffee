# Load dependencies -----
app      = require("../app")
cradle   = require("cradle")
fs       = require("fs")
conf     = require("../config/global.conf")
db       = new(cradle.Connection)().database("ezypzy")
# ------

# Routes ==============================================================================

routes = ->

  # Home page --------------------------------------
  app.get "/", (req, res) ->
    res.render "index"
  # ------------------------------------------------

  # Register ---------------------------------------
  app.get "/register", (req, res) ->
    res.render "register"

  app.post "/register", (req, res) ->
    name  = req.body.name
    email = req.body.email

    db.save "items",
      name  : name
      email : email
    , (err, result) ->
      if err
        console.log err
      else
        res.redirect "/"

  # ------------------------------------------------

  # Login ------------------------------------------
  app.get "/login", (req, res) ->
    res.render "login"

  app.post "/login", (req, res) ->
    name  = req.body.name
    email = req.body.email

    db.get "items", (err, doc) ->
      if name is doc.name && email is doc.email
        res.redirect "/"
      else
        res.send "Failed"

  # ------------------------------------------------




# =====================================================================================




# Functions for routes ================================================================

# Lightweight view layer -----
# viewLayer = (viewFile) ->
#   html = fs.readFileSync "#{ process.cwd() }/views/#{ viewFile }", "utf8"

#   return html
# # -----

# # Home -----
# home = (route) ->
#   viewFile = "index.html"

#   @res.writeHead 200, { "Content-Type": "text/html" }
#   @res.end viewLayer(viewFile)
# #-----

# # Register -----
# register = (route) ->
#   viewFile = "register.html"

#   @res.writeHead 200, { "Content-Type" : "text/html" }
#   @res.end viewLayer(viewFile)

# registerPost = ->
#   options =
#     host   : "127.0.0.1"
#     port   : conf.port
#     path   : "/register"
#     method : "POST"

#   req = http.request options, (res) ->

#     res.setEnconding "utf8"

#     res.on 'data', (chunk) ->
#       console.log('BODY: ' + chunk)

#   req.on 'error', (e) ->
#     console.log('problem with request: ' + e.message)

#   req.end()
# # ----

# # =====================================================================================

# # Defining router =====================================================================

# router = new director.http.Router
#   # Home path "../" -----
#   "/" :
#     get : home
#   # -------

#   # Register path "../register" -----
#   "/register" :
#     get  : register
#     post : registerPost
#   # ------

# # =====================================================================================

# # Creating server =====================================================================
# server = http.createServer (req, res) ->

#   # Dispatching router -----
#   router.dispatch req, res, (err) ->

#     if err
#       res.writeHead(404)
#       res.end()
#   # -----

# # =====================================================================================

# # Binding routes into router ==========================================================

# router.get("/", home) # Home

# # =====================================================================================

# Exports the server to app.js -----
module.exports =
  routes : routes
# -----
