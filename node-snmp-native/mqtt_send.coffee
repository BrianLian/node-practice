mqtt = require("mqtt")

options =
	port: 6260
client = mqtt.connect('ws://192.168.16.175', options)

r = 0
job = null

sendMsg = (message) ->
	r = Math.floor((Math.random() * 10) + 1)
	obj =
			name: "brian"
			num : r
	client.publish "brian/", JSON.stringify(obj)

client.on 'connect', ()->
	console.log "Connected !!"
	job = setInterval sendMsg, 2000
