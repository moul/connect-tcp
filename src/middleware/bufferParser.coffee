debug = require('debug') 'connect-tcp:middleware:bufferParser'

bufferParser = exports = module.exports = ->
  middleware = (req, res, next) ->
    req.data = req.buffer.toString()
    req.data = req.data.replace /^\s+|\s+$/g, ""
    do next
  return middleware
