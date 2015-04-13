CSON = require 'cson'
fs = require 'fs'

conf = CSON.load 'conf.cson'

Object.prototype.describe = ->
  "#{k}: #{v}" for k, v of this

# Date conversion
Array.prototype.toDate = ->
  new Date this[..5]

Date.prototype.toArray = ->
  [ @getFullYear(),
    @getMonth() + 1,
    @getDate(),
    @getHours(),
    @getMinutes(),
    @getSeconds() ]

class Utils

  # Logs
  log = (message) ->
    currentTime = new Date
    timedMessage = "#{currentTime.toString()} #{message}\n"
    console.log message if conf.verbose
    fs.appendFile conf.logFile, timedMessage, (err) ->
      console.error err if err?

  @logInfo: (message) ->
    log "[INFO] #{message}"

  @logWarn: (message) ->
    log "[WARN] #{message}"

  @logError: (message) ->
    log "[ERROR] #{message}"

module.exports = Utils
