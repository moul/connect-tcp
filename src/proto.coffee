utils = require './utils'
debug = require('debug') 'connect-tcp:dispatcher'
net = require 'net'

exports = module.exports = app = {}

app.use = (fn) ->
  debug "use %s", fn.name || 'anonymous'
  this.stack.push handle: fn
  return this

app.handle = (connection, out) ->
  stack = @stack
  index = 0

  next = (err) ->
    layer = stack[index++]

    unless layer
      return out err if out
      # TODO: default error handling
      connection.end()
      return

    try
      arity = layer.handle.length
      if err
        if arity is 3
          layer.handle err, connection, next
        else
          next err
      else if arity < 3
        layer.handle connection, next
      else
        do next
    catch e
      next e

  do next

app.listen = ->
  server = net.createServer this
  server.listen.apply server, arguments
