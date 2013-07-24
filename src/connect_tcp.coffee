{EventEmitter} = require 'events'
proto = require './proto'
utils = require './utils'
fs = require 'fs'
path = require 'path'
basename = path.basename
debug = require('debug') 'connect-tcp:main'

createServer = ->
  debug 'createServer'
  app = (socket, next) ->
    app.sock_handle socket, next
    socket.on 'data', (buffer) ->
      req =
        buffer: buffer
        #data:   buffer.toString()
        socket: socket
      res =
        send: (data) -> socket.write data + '\n'
      app.data_handle req, res, next
  utils.merge app, proto
  utils.merge app, EventEmitter.prototype
  app.sock_stack = []
  app.data_stack = []
  app.use arg for arg of arguments
  return app

exports = module.exports = createServer
exports.version = '0.2.0'
exports.middleware = {}
exports.utils = utils
createServer.createServer = createServer

fs.readdirSync("#{__dirname}/middleware").forEach (filename) ->
  return unless /\.js$/.test(filename)
  name = basename filename, '.js'
  load = -> require "./middleware/#{name}"
  exports.middleware.__defineGetter__ name, load
  exports.__defineGetter__ name, load
