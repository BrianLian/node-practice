mqtt = require("mqtt")

options =
	port: 8883
client = mqtt.connect('ws://128.199.103.93', options)

r = 0
job = null

sendMsg = (message) ->
	r = Math.floor((Math.random() * 10) + 1)
	obj =
			name: "brian"
			num : r
	client.publish "/view/", JSON.stringify(obj)

client.on 'connect', ()->
	console.log "Connected !!"
	job = setInterval sendMsg, 2000
