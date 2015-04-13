# threads/ops
map = (doc) ->
  if doc.type == 'thread'
    content =
      _id: doc._id
      _rev: doc._rev
      author: doc.author
      date: doc.date
      text: doc.text
      board: doc.board
    emit [doc.board, doc.date], content

# threads/all
map = (doc) ->
  if doc.type == 'thread'
    emit [doc.board, doc.date], doc

# posts/by_thread
map = (doc) ->
  if doc.type == 'thread'
    emit [doc._id, doc.date], doc.posts

# posts/all
map = (doc) ->
  if doc.type == 'thread'
    for post in doc.posts
      emit [doc._id, post.date], post

# boards/by_name
map = (doc) ->
  if doc.type == 'board'
    emit doc.name, doc
