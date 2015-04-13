express = require 'express'

util = require './util'
logger = require './middleware/logger'
board = require './routes/board'

app = new express()

publicDir = __dirname + '/public'
viewsDir = __dirname + '/views'

# Configuration
app.set 'views', viewsDir
app.set 'view engine', 'jade'

# Middlewares
app.use logger
app.use express.static(publicDir)
app.use '/snw', board

# Routes
app.get '/', (req, res) ->
  res.sendFile "#{publicDir}/index.html"

module.exports = app
