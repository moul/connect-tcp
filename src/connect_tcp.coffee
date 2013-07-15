{EventEmitter} = require 'events'
proto = require './proto'
utils = require './utils'
fs = require 'fs'
path = require 'path'
basename = path.basename

createServer = ->
  app = (socket, next) ->
    app.handle(socket, next)
  utils.merge app, proto
  utils.merge app, EventEmitter.prototype
  app.stack = []
  for arg of arguments
    app.use arg
  return app

exports = module.exports = createServer

exports.version = '0.1.0'

exports.middleware = {}

exports.utils = utils

createServer.createServer = createServer

fs.readdirSync("#{__dirname}/middleware").forEach (filename) ->
  return unless /\.js$/.test(filename)
  name = basename filename, '.js'
  load = -> require "./middleware/#{name}"
  exports.middleware.__defineGetter__ name, load
  exports.__defineGetter__ name, load
