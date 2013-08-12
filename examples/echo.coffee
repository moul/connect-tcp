#!/usr/bin/env coffee
#
# coffee ./echo.coffee
# nc localhost 3045

connect_tcp = require '..'

server = connect_tcp.createServer()

server.use connect_tcp.echo()

server.listen 3045, -> console.log "listening on port 3045"
