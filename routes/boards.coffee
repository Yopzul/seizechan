express = require 'express'
bodyParser = require 'body-parser'

urlencode = bodyParser.urlencoded {extended: no}
boards = express.Router()

allBoards =
  snw: 'Sora no Woto discussion'
  loli: 'Loli discussion'

boards.route '/'
.get (req, res) ->
  res.status 200
  .json allBoards

module.exports = boards
