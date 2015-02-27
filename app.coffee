express = require 'express'

util = require './util'
logger = require './middleware/logger'
boards = require './routes/boards'

app = new express()

coffeeDir = __dirname + "/public/coffee"
publicDir = __dirname + "/publis/js"

app.use logger
app.use express.static(publicDir)

app.use '/boards', boards

module.exports = app
