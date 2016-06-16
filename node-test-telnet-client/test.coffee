net = require 'net'
conn = net.connect 23, '192.168.16.71', () ->
#conn = net.createConnection 23, '192.168.16.71', () ->
    console.log 'client connected'

conn.setTimeout 3000
conn.on 'close', (has_error) ->
  if has_error
    console.log 'client disconnected has error'
  else
    console.log 'client disconnected has no error'
conn.on 'data', (data) ->
  buffer = new Buffer data
  response = buffer.toString()
  console.log data
  console.log response 
  if response.length > 0
    console.log 'response length > 0'
conn.on 'timeout', () ->
  console.log 'client timeout'
  conn.destroy()
conn.on 'error', (err) ->
  console.log err
  conn.destroy()
    
#setTimeout () ->
#  conn.end() 
#, 3000
