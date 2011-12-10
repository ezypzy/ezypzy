{ spawn, exec } = require "child_process"
sys             = require "util"

printData = (process) ->

  process.stdout.on 'data', (data) -> sys.print data
  process.stderr.on 'data', (data) -> sys.print data

task 'watch', 'watch all coffeescript files for changes', ->

  coffee  = spawn("coffee", ["-o", "./", "-cwb ", "src/"])

  printData(coffee)

task 'watchJS', 'watches coffeescript files for changes', ->

  coffee = spawn("coffee", ["-o", "./", "-cwb", "src/"])

  printData(coffee)

