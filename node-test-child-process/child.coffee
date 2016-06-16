process.on 'message', (m) ->
  console.log 'Got message from parent: ', m

counter = 0
doSomething = () ->
  process.send { pid: process.pid, counter: ++counter }

clearSomething = () ->
  console.log "clearInterval, pid is #{process.pid} killed."
  clearTimeout intervalObj

intervalObj = setInterval doSomething, 2000

#setTimeout clearSomething, 100000