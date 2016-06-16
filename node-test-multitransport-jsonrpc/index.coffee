childProcess = require 'child_process'
jsonrpc = require 'multitransport-jsonrpc'

JsonRpcClient = jsonrpc.client
ChildProcessTransport = jsonrpc.transports.client.childProcess
child = childProcess.fork('child.js');
jsonRpcClient = new JsonRpcClient new ChildProcessTransport child
jsonRpcClient.register ['loopback', 'failure'] 

jsonRpcClient.loopback {name: 'apple'}, (err, result) ->
  console.log result
jsonRpcClient.failure {name: 'sky'}, (err, result) ->
  console.log result