should = require('chai').should()
Board = require '../../models/board'

describe 'Boards', ->

  describe 'Getting boards', ->
    it 'Should return an array of boards', ->
      Board.all()
      .then (boards) ->
        boards.should.be.an.instanceOf Array
        for board in boards
          board.should.have.property 'type'
          board.type.should.equal 'board'

  describe 'Getting the threads', ->
    it 'Should returns all the threads of a specific board', ->
      Board.find 'snw'
      .then (board) ->
        board.getThreads()
        .then (threads) ->
          threads.should.be.an.instanceOf Array
          for thread in threads
            thread.should.have.property 'board'
            thread.board.should.equal 'snw'
