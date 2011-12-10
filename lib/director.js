var director, home, http, router, server;

http = require("http");

director = require("director");

home = function(route) {
  this.res.writeHead(200, {
    'Content-Type': 'text/plain'
  });
  return this.res.end('Snap.Share.Sell');
};

router = new director.http.Router({
  "/": {
    get: home
  }
});

server = http.createServer(function(req, res) {
  return router.dispatch(req, res, function(err) {
    if (err) {
      res.writeHead(404);
      return res.end();
    }
  });
});

router.get("/", home);

module.exports = server;
