mqtt = require("mqtt")

options =
  port: 8883
client = mqtt.connect('ws://128.199.103.93', options)

client.on 'connect', ()->
  console.log "Connected !!"
  client.subscribe '/view/#'

client.on 'message', (topic, message) ->
  #message is Buffer
  console.log "#{topic}:"
  # console.log "#{topic}: #{message.toString()}"
