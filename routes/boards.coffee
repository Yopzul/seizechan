express = require 'express'
bodyParser = require 'body-parser'

urlencode = bodyParser.urlencoded {extended: no}
boards = express.Router()

boards.route '/'
.get (req, res) ->
  res.sendStatus 200

.put (req, res) ->
  res.sendStatus 201

module.exports = boards
