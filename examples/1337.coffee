#!/usr/bin/env coffee
#
# DEBUG='*' coffee ./echo.coffee
# nc localhost 3044

debug = require('debug') 'connect-tcp:examples:echo'
connect_tcp = require '..'

server =         connect_tcp.createServer()
server.use      connect_tcp.logger()
server.sock_use connect_tcp.logger.sock_logger()

server.use connect_tcp.bufferParser()

server.use (req, res, next) ->
  debug 'uppercasing data'
  req.data = req.data.toUpperCase()
  do next

server.use (req, res, next) ->
  debug '1337ing data'
  translations =
    0: /[oO]/
    1: /[lL]/
    2: /[zZ]/
    3: /[eE]/
    4: /[aA]/
    5: /[sS]/
    6: /[gG]/
    7: /[tT]/
    8: /[bB]/
  for translation, exp of translations
    req.data = req.data.replace exp, translation.toString()
  do next

server.use (req, res, next) ->
  debug 'reversing letters'
  req.data = req.data.split('').reverse().join('')
  do next

server.use (req, res, next) ->
  debug 'sending back data', req.data
  res.send req.data
  do next

server.listen 3044, -> debug "listening on port 3044"
