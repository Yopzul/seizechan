express = require 'express'

util = require './util'
logger = require './middleware/logger'
boards = require './routes/boards'

app = new express()

coffeeDir = __dirname + '/public/coffee'
publicDir = __dirname + '/publis/js'
viewsDir =  __dirname + '/views'

app.use logger
app.set 'views', viewsDir
app.set 'view engine', 'jade'
app.use express.static(publicDir)

app.use '/boards', boards

app.get '/', (req, res) ->
  res.render 'index'

module.exports = app
