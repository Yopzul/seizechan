CSON = require 'cson'
Q = require 'q'

util = require '../util'
Module = require '../module'

conf = CSON.load 'conf.cson'
nano = require('nano')
  url: process.env.COUCHURL or conf.couchdb.url
db = nano.use(conf.couchdb.database)



class Document

  initialize = (doc, obj) ->
    for key, val of obj when key not in ['rev', 'id'] and typeof val isnt 'function'
      doc[key] = val
    doc._rev = obj.rev if obj.rev?
    return doc

# Class methods

  constructor: (row) ->
    @_id = row.id
    initialize(this, row.value)

  update: (obj) =>
    ddoc = new Object
    initialize(ddoc, this)
    initialize(ddoc, obj)
    Q.ninvoke nano, 'request',
      db: conf.couchdb.database
      method: 'PUT'
      doc: @_id
      body: ddoc
    .then (result) =>
      res = result[0]
      if res.ok == true
        initialize(this, ddoc)
        @_rev = res.rev
      return res

  destroy: ->
    Q.ninvoke db, 'destroy', @_id
    .then (result) -> result[0]

# Static methods

  @get: (params) ->
    Q.ninvoke db, 'list', params
    .then (results) ->
      new Document(row) for row in results[0].rows

  @all: ->
    @get null

  @first: ->
    @get(limit: 1)
    .then (docs) -> docs[0] or null

  @last: ->
    @get(limit: 1, descending: yes)
    .then (docs) -> docs[0] or null

  @find: (name) ->
    @get(key: name)
    .then (docs) -> docs[0] or null

  @create: (obj, name) ->
    Q.ninvoke db, 'insert', obj, name or undefined
    .then (result) -> result[0] or null

module.exports = Document
