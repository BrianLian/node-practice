mqtt = require("mqtt")

options =
  port: 6260
client = mqtt.connect('ws://192.168.16.175', options)

client.on 'connect', ()->
  console.log "Connected !!"
  client.subscribe '/view/#'

client.on 'message', (topic, message) ->
  #message is Buffer
  console.log "#{topic}:"
  # console.log "#{topic}: #{message.toString()}"
