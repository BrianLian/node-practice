childs = []
i = 0
childs[i] = require('child_process').fork('child.js')
childs[i].on 'message', (msg) ->
  console.log "Got message from child pid is #{msg.pid}"
  console.log "  #{msg.counter}"

setTimeout () ->
  childs[i].send 'Hello'
, 2000
###
setTimeout () ->
  childs[0].kill('SIGTERM')
, 100000
###