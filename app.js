var flatiron = require('flatiron'),
    path = require('path')
    app = flatiron.app;

app.use(flatiron.plugins.cli, {
  dir: path.join(__dirname,'lib','commands'),
  usage: 'Empty Flatiron Application, please fill out commands'
});

if (require.main === module) {
  app.init(function () {
    app.start();
  });
}
