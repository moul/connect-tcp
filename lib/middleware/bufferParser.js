// Generated by CoffeeScript 1.6.3
(function() {
  var bufferParser, debug, exports;

  debug = require('debug')('connect-tcp:middleware:bufferParser');

  bufferParser = exports = module.exports = function() {
    var middleware;
    middleware = function(req, res, next) {
      req.data = bufferParser.bufferToString(req.buffer);
      return next();
    };
    return middleware;
  };

  bufferParser.bufferToString = function(buffer) {
    var string;
    string = buffer.toString();
    string = string.replace(/^\s+|\s+$/g, "");
    return string;
  };

}).call(this);
