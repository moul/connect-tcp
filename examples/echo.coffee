#!/usr/bin/env coffee
#
# coffee ./echo.coffee
# nc localhost 3045

connect_tcp = require '..'

server = connect_tcp.createServer()

server.use connect_tcp.bufferParser()

server.use (req, res, next) ->
  res.send req.data
  do next

server.listen 3045, -> console.log "listening on port 3045"
