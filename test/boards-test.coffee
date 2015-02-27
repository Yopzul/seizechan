request = require 'supertest'
app = require '../app'

describe 'Getting boards', ->
  it 'Returns 200', (done) ->
    request app
    .get '/boards'
    .expect 200, done

  it 'Is JSON', (done) ->
    request app
    .get '/boards'
    .expect 'Content-Type', /json/, done
