CSON = require 'cson'
Q = require 'q'
_ = require 'lodash'

util = require '../util'
Document = require './document'

conf = CSON.load 'conf.cson'
nano = require('nano')
  url: process.env.COUCHURL or conf.couchdb.url
db = nano.use(conf.couchdb.database)

class Thread extends Document

  getPosts: (params = {}) ->
    params.startkey = [@_id, [0,0,0,0,0,0]]
    params.endkey = [@_id, new Date().toArray()]
    Q.ninvoke db, 'view', 'posts', 'by_thread', params
    .then (results) ->
      @posts = results[0].rows[0]?.value

  updatePosts = (fn) ->
    if @posts?
      fn()
      @update()
    else
      @getPosts()
      .then ->
        fn()
        @update()

  addPost: (post) =>
    updatePosts => @posts.push post

  deletePost: (index) =>
    updatePosts =>
      @posts[index] = null
      @posts = _.compact @posts

  @get: (params = {posts: yes}) ->
    view = if params.posts then 'all' else 'ops'
    params.posts = undefined
    Q.ninvoke db, 'view', 'threads', view, params
    .then (results) ->
      new Thread(row) for row in results[0].rows

  @find: (id, params = {posts: yes}) ->
    params.key = id
    @get params
    .then (docs) -> docs[0] or null

module.exports = Thread
