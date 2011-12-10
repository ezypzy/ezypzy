http     = require("http")
director = require("director")

# Testing
home = (route) ->
  this.res.writeHead(200, { 'Content-Type': 'text/plain' })
  this.res.end('Snap.Share.Sell')


router = new director.http.Router
  "/" :
    get : home


server = http.createServer (req, res) ->
  router.dispatch req, res, (err) ->
    if err
      res.writeHead(404)
      res.end()

router.get("/", home)

module.exports = server
