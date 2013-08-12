debug = require('debug') 'connect-tcp:middleware:echo'

echo = exports = module.exports = ->
  middleware = (req, res, next) ->
    debug "write #{req.buffer.length} bytes"
    res.write req.buffer
    do next
  return middleware
