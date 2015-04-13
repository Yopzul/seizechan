should = require('chai').should()
Document = require '../../models/document'

describe 'Documents', ->

  describe 'Getting all documents', ->
    it 'Should return an array of documents', ->
     Document.all()
      .then (docs) ->
        docs.should.be.an.instanceOf Array
        for doc in docs
          doc.should.have.property '_rev'

  describe 'Finding a specific document', ->
    it 'Should return the correct document', ->
      Document.find '-test'
      .then (doc) ->
        should.exist doc
        doc.should.be.an.instanceOf Object
        doc.should.have.property '_rev'

  describe 'Getting the first document', ->
    it 'Should only return one document', ->
      Document.first()
      .then (doc) ->
        should.exist doc
        doc.should.be.an.instanceOf Object
        doc.should.have.property '_rev'

  describe 'Getting the last document', ->
    it 'Should only return one document', ->
      Document.last()
      .then (doc) ->
        should.exist doc
        doc.should.be.an.instanceOf Object
        doc.should.have.property '_rev'

  describe 'Updating a document', ->
    it 'Should update the document', ->
      Document.find '-test'
      .then (doc) =>
        prev_rev = doc._rev
        should.exist doc
        doc.update(bar: 'bazz')
        .then (res) =>
          res.should.have.property 'ok'
          res.ok.should.be.ok
          res.rev.should.not.equal prev_rev

  ###
  describe 'Creating a document', ->
    it 'Should create a document', ->
      Document.create {foo: 'bar'}, '-dummy'
      .then (res) ->
        res.should.have.property 'ok'
        res.ok.should.be.ok
        res.should.have.property 'id'
        res.id.should.equal '-dummy'

  describe 'Deleting a document', ->
    it 'Should delete the document', ->
      Document.find '-dummy'
      .then (doc) ->
        should.exist doc
        doc.destroy()
        .then (res) ->
          res.should.have.property 'ok'
          res.ok.should.be.ok
  ###
