debug = require('debug') 'connect-tcp:middleware:logger'

logger = exports = module.exports = (options) ->
  if 'object' is typeof options
    options ?= {}
  else if options
    options = format: options
  else
    options = {}

  logger = (req, res, next) ->
    debug "Message from logger"
    do next

  return logger

module.exports.sock_logger = (options) ->
  sock_logger = (connection, next) ->
    debug "Message from sock_logger"
    connection.on 'end',   -> debug 'message from sock_logger on end'
    connection.on 'data',  -> debug 'message from sock_logger on data'
    connection.on 'error', -> debug 'message from sock_logger on error'
    do next

  return sock_logger
