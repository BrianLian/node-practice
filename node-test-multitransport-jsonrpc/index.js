// Generated by CoffeeScript 1.8.0
(function() {
  var ChildProcessTransport, JsonRpcClient, child, childProcess, jsonRpcClient, jsonrpc;

  childProcess = require('child_process');

  jsonrpc = require('multitransport-jsonrpc');

  JsonRpcClient = jsonrpc.client;

  ChildProcessTransport = jsonrpc.transports.client.childProcess;

  child = childProcess.fork('child.js');

  jsonRpcClient = new JsonRpcClient(new ChildProcessTransport(child));

  jsonRpcClient.register(['loopback', 'failure']);

  jsonRpcClient.loopback({
    name: 'apple'
  }, function(err, result) {
    return console.log(result);
  });

  jsonRpcClient.failure({
    name: 'sky'
  }, function(err, result) {
    return console.log(result);
  });

}).call(this);
