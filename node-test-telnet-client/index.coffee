telnet = require 'telnet-client'
connection = new telnet()

params = 
  host : '192.168.16.71'
  timeout: 1500

connection.on 'ready', (prompt) ->
  console.log 'connection ready'
  connection.exec cmd, (response) ->
    console.log response

connection.on 'timeout', () ->
  console.log 'socket timeout!'
  connection.end()

connection.on 'close', () ->
  console.log 'connection closed'

connection.connect params
