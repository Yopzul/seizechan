# Logging middleware
util = require '../util'

module.exports = (req, res, next) ->
  util.logInfo "#{req.method} on #{req.url}"
  next()
