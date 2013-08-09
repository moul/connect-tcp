debug = require('debug') 'connect-tcp:middleware:bufferParser'

bufferParser = exports = module.exports = ->
  middleware = (req, res, next) ->
    req.data = bufferParser.bufferToString req.buffer
    do next
  return middleware

bufferParser.bufferToString = (buffer) ->
  string = buffer.toString()
  string = string.replace /^\s+|\s+$/g, ""
  return string
