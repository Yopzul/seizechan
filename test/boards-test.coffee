request = require 'supertest'
app = require '../app'

describe 'Boards', ->
  describe 'Getting boards', ->
    it 'Returns 200', (done) ->
      request app
      .get '/boards'
      .expect 200, done

    it 'Is JSON', (done) ->
      request app
      .get '/boards'
      .expect 'Content-Type', /json/, done

  describe 'Creating a board', ->
    it 'Returns 201', (done) ->
      request app
      .put '/boards'
      .send JSON.stringify('')
      .expect 201, done

    it 'Is JSON', (done) ->
      request app
      .put '/boards'
      .send JSON.stringify('')
      .expect 'Content-Type', /json/, done
