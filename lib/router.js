var Plates, director, fs, home, http, router, server, viewLayer;

http = require("http");

director = require("director");

Plates = require("plates");

fs = require("fs");

viewLayer = function(viewFile) {
  var html;
  html = fs.readFileSync("" + (process.cwd()) + "/views/" + viewFile, "utf8");
  return html;
};

home = function(route) {
  var viewFile;
  viewFile = "index.html";
  this.res.writeHead(200, {
    'Content-Type': 'text/html'
  });
  return this.res.end(viewLayer(viewFile));
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
