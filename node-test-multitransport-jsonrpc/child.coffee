jsonrpc = require 'multitransport-jsonrpc'
JsonRpcServer = jsonrpc.server
JsonRpcChildProcTransport = jsonrpc.transports.server.childProcess

server = new JsonRpcServer new JsonRpcChildProcTransport(), {
    loopback: (obj, callback) ->
        console.log "[child] loopback"
        console.log obj.name
        callback null, "loopback return"
    ,
    failure: (obj, callback) ->
        console.log "[child] loopback"
        console.log obj.name
        callback null, "failure return"
}