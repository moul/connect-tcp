debug = require('debug') 'connect-tcp:examples:logger'
connect_tcp = require '..'

# version 1
connect_tcp.createServer(
  connect_tcp.logger()
).listen 3042


# version 2
server = connect_tcp.createServer()
server.use connect_tcp.logger()
server.use (connection, next) -> debug 'log from anonymous function'
server.listen 3043
