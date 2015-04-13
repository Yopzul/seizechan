CSON = require 'cson'
Q = require 'q'

util = require '../util'
Document = require './document'
Thread = require './thread'

conf = CSON.load 'conf.cson'
nano = require('nano')
  url: process.env.COUCHURL or conf.couchdb.url
db = nano.use conf.couchdb.database

class Board extends Document

  getThreads: (params = {}) ->
    params.startkey = [@name, [0,0,0,0,0,0]]
    params.endkey = [@name, new Date().toArray()]
    Thread.get params
    .then (threads) ->
      @threads = threads
      return @threads

  @get: (params) =>
    Q.ninvoke db, 'view', 'boards', 'by_name', params
    .then (results) ->
      new Board(row) for row in results[0].rows

module.exports = Board
