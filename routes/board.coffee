express = require 'express'
bodyParser = require 'body-parser'
CSON = require 'cson'

urlencode = bodyParser.urlencoded {extended: no}

module.exports = (boardName) ->
  board = express.Router()

  # TODO: get from db
  board.route '/'
  .get (req, res) ->
    res.sendStatus 404

  board.route '/:thread'
  .all (req, res) ->
    req.thread = +req.params.thread
  .get (req, res) ->
    res.sendStatus 404

  return board
