request = require 'supertest'
app = require '../app'

describe 'Root', ->
  describe 'Request on root', ->
    it 'Returns 200', (done) ->
      request app
      .get '/'
      .expect 200, done

    it 'Is HTML', (done) ->
      request app
      .get '/'
      .expect 'Content-Type', /html/, done
