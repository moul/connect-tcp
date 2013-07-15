debug = require('debug') 'connect-tcp:middleware:logger'

logger = exports = module.exports = (options) ->
  if 'object' is typeof options
    options ?= {}
  else if options
    options = format: options
  else
    options = {}

  logger = (connection, next) ->
    debug "Message from logger"
    do next

  return logger
