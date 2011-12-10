# Load dependencies -----
http     = require("http")
director = require("director")
Plates   = require("plates")
fs       = require("fs")
# ------

# Functions for routes ================================================================

# Lightweight view layer -----
viewLayer = (viewFile) ->
  html = fs.readFileSync "#{ process.cwd() }/views/#{ viewFile }", "utf8"

  return html
# -----

# Home -----
home = (route) ->
  viewFile = "index.html"

  @res.writeHead(200, { 'Content-Type': 'text/html' })
  @res.end(viewLayer(viewFile))
#-----


# =====================================================================================

# Defining router =====================================================================

router = new director.http.Router
  # Home path "../" -----
  "/" :
    get : home
  # -------

# =====================================================================================

# Creating server =====================================================================
server = http.createServer (req, res) ->

  # Dispatching router -----
  router.dispatch req, res, (err) ->

    if err
      res.writeHead(404)
      res.end()
  # -----

# =====================================================================================

# Binding routes into router ==========================================================

router.get("/", home) # Home

# =====================================================================================

# Exports the server to app.js -----
module.exports = server
# -----
