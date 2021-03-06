// Generated by CoffeeScript 1.6.3
(function() {
  var EventEmitter, basename, createServer, debug, exports, fs, path, proto, utils;

  EventEmitter = require('events').EventEmitter;

  proto = require('./proto');

  utils = require('./utils');

  fs = require('fs');

  path = require('path');

  basename = path.basename;

  debug = require('debug')('connect-tcp:main');

  createServer = function() {
    var app, arg;
    debug('createServer');
    app = function(socket, next) {
      app.sock_handle(socket, next);
      if (socket.session == null) {
        socket.session = {};
      }
      return socket.on('data', function(buffer) {
        var req, res;
        req = {
          buffer: buffer,
          socket: socket,
          session: socket.session
        };
        res = {
          send: function(data) {
            return socket.write(data + '\n');
          },
          write: function(data) {
            return socket.write(data);
          }
        };
        return app.data_handle(req, res, next);
      });
    };
    utils.merge(app, proto);
    utils.merge(app, EventEmitter.prototype);
    app.sock_stack = [];
    app.data_stack = [];
    for (arg in arguments) {
      app.use(arg);
    }
    return app;
  };

  exports = module.exports = createServer;

  exports.version = '0.2.0';

  exports.middleware = {};

  exports.utils = utils;

  createServer.createServer = createServer;

  fs.readdirSync("" + __dirname + "/middleware").forEach(function(filename) {
    var load, name;
    if (!/\.js$/.test(filename)) {
      return;
    }
    name = basename(filename, '.js');
    load = function() {
      return require("./middleware/" + name);
    };
    exports.middleware.__defineGetter__(name, load);
    return exports.__defineGetter__(name, load);
  });

}).call(this);
