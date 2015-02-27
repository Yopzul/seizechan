express = require 'express'

util = require './util'
logger = require './middleware/logger'
boards = require './routes/boards'

app = new express()

publicDir = __dirname + '/public'

# Middlewares
app.use logger
app.use express.static(publicDir)
app.use '/boards', boards

# Routes
app.get '/', (req, res) ->
  res.sendFile '#{publicDir}/index.html'

module.exports = app
