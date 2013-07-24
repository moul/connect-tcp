#!/usr/bin/env coffee
#
# DEBUG='*' coffee ./logger.coffee
# nc localhost 3043

debug = require('debug') 'connect-tcp:examples:logger'
connect_tcp = require '..'

# version 1
connect_tcp.createServer(
  connect_tcp.logger()
).listen 3042, -> debug "listening on port 3042"

# version 2
server = connect_tcp.createServer()
server.use connect_tcp.logger()
server.listen 3043, -> debug "listening on port 3043"
