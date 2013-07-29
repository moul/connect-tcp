#!/usr/bin/env coffee
#
# coffee ./session.coffee
# nc localhost 3046

connect_tcp = require '..'

server = connect_tcp.createServer()

server.use connect_tcp.bufferParser()

server.use (req, res) ->
  req.session.line ?= 0
  req.session.line++
  res.send "line = #{req.session.line}"

server.listen 3046, -> console.log "listening on port 3046"
