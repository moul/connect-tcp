utils = require './utils'
debug = require('debug') 'connect-tcp:proto'
net = require 'net'

exports = module.exports = app = {}

app.use = app.data_use = (fn) ->
  debug "data_use %s", fn.name || 'anonymous'
  @data_stack.push handle: fn
  return this

app.handle = app.data_handle = (req, res, out) ->
  data_stack = @data_stack
  index = 0

  next = (err) ->
    layer = data_stack[index++]

    unless layer
      return out err if out
      # TODO: default error handling
      #socket.end()
      return

    try
      arity = layer.handle.length
      if err
        if arity is 4
          layer.handle err, req, res, next
        else
          next err
      else if arity < 4
        layer.handle req, res, next
      else
        do next
    catch e
      next e

  do next

app.sock_use = (fn) ->
  debug "sock_use %s", fn.name || 'anonymous'
  @sock_stack.push handle: fn
  return this

app.sock_handle = (connection, out) ->
  sock_stack = @sock_stack
  index = 0

  next = (err) ->
    layer = sock_stack[index++]

    unless layer
      return out err if out
      # TODO: default error handling
      #connection.end()
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
