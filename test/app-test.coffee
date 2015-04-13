request = require 'supertest'
app = require '../app'

describe 'Root', ->

  describe 'Request on root', ->
    it 'Is HTML', (done) ->
      request app
      .get '/'
      .expect 200
      .expect 'Content-Type', /html/, done
