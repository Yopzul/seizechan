CSON = require 'cson'
fs = require 'fs'

conf = CSON.load 'conf.cson'

class Utils

  log: (message) ->
    currentTime = new Date()
    timedMessage = "#{currentTime.toString()} #{message}\n"
    console.log message if conf.verbose
    fs.appendFile conf.logFile, timedMessage, (err) ->
      console.error err if err?

  logInfo: (message) ->
    @log "[INFO] #{message}"

  logWarn: (message) ->
    @log "[WARN] #{message}"

  logError: (message) ->
    @log "[ERROR] #{message}"

module.exports = new Utils();
