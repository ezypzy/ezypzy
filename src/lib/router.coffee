# Load dependencies -----
util     = require("util")
app      = require("../app")
cradle   = require("cradle")
fs       = require("fs")
conf     = require("../config/global.conf")
db       = new(cradle.Connection)('http://localhost', 5984, {
  cache: true,
  raw: false
}).database("ezypzy")

# ------

# Routes ==============================================================================

routes = ->

  # Home page --------------------------------------
  app.get "/", (req, res) ->
    data =
      loggedIn : false

    if req.session.loggedIn is true
      data =
        loggedIn : true

    res.render "index", data
  # ------------------------------------------------

  # Register ---------------------------------------
  app.get "/register", (req, res) ->
    res.render "register"

  app.post "/register", (req, res) ->
    name  = req.body.name
    email = req.body.email

    db.save "users",
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

    db.get "users", (err, doc) ->

      if name is doc.name and email is doc.email
        req.session.loggedIn = true
        res.redirect "/"
      else
        res.send "Failed"

        setTimeout ->
          res.redirect "/"
        , 3000
  # ------------------------------------------------

  # Feeds ------------------------------------------
  app.get "/feeds", (req, res) ->

    db.all (err, doc) ->

      data = []
      for d in doc
        if /items/.test(d.id) is true

          db.get d.id, (err, res) ->
            dd =
              name  : res.description
              path  : res.image
              price : res.price

            data.push dd

      process.nextTick ->
        res.render "feeds", { data : data }
  # ------------------------------------------------

  # Sell -------------------------------------------
  app.get "/sell", (req, res) ->
    res.render "sell"

  app.post "/sell", (req, res, next) ->
    image = req.body.image
    desc  = req.body.description
    price = req.body.price
    ins   = fs.createReadStream req.files.image.path
    ous   = fs.createWriteStream "#{ process.cwd() }/public/images/items/#{ req.files.image.filename }"
    src   = "/images/items/#{ req.files.image.filename }"

    util.pump ins, ous, (err) ->
      if err
        next(err)
      else

        db.save "items" + Math.random(),
          description : desc
          image       : src
          price       : price
        , (err, result) ->
          if err
            console.log err
          else
            res.redirect("/feeds")

  # ------------------------------------------------

  # Buy --------------------------------------------
  app.get "/buy", (req, res) ->
    res.render "buy"
  # ------------------------------------------------



# =====================================================================================

# Exports the server to app.js -----
module.exports =
  routes : routes
# -----
