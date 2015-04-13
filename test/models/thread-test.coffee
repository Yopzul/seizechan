should = require('chai').should()
_ = require 'lodash'

Thread = require '../../models/thread'

describe 'Threads', ->

  describe "Getting a thread's posts", ->
    it 'Should return the posts of a thread', ->
      Thread.find ['test', [1970, 1, 1, 0, 0, 0]]
      .then (thread) ->
        should.exist thread
        thread.getPosts()
        .then (posts) ->
          should.exist posts
          posts.should.be.an.instanceOf Array
          for post in posts
            post.should.have.property 'text'
            post.should.have.property 'author'
            post.should.have.property 'date'

  describe "Adding a post", ->
    it 'Should add a post and update the thread', ->
      post =
        author:
          ip: '127.0.0.1'
          name: 'Anon'
        date: [1970, 1, 1, 0, 0, 0]
        text: "We didn't start the fire"
      Thread.find ['test', [1970, 1, 1, 0, 0, 0]]
      .then (thread) ->
        should.exist thread
        thread.addPost post
        .then ->
          post.text.should.equal _.last(thread.posts).text

  describe "Deleting a post", ->
    it 'Should delete the post', ->
      Thread.find ['test', [1970, 1, 1, 0, 0, 0]]
      .then (thread) ->
        should.exist thread
        thread.should.have.property 'posts'
        thread.deletePost 3
        .then ->
          thread.posts.length.should.equal 2
