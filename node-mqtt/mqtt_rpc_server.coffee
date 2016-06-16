mqtt = require('mqtt')
mqttrpc = require('mqtt-rpc')

settings =
	port: 8080
	reconnectPeriod: 5000

mqttclient = mqtt.connect('ws://test.mosquitto.org', settings)
mqttclient.on "connect", ()->
	console.log "connected !"

server = mqttrpc.server(mqttclient)
# server.format('json')
server.format('msgpack')

server.provide 'view/110ec58a-a0f2-4ac4-8393-c866d813b8d1', 'time', (args, cb)->
	console.log("on request time on server")
	cb(null, new Date())

server.provide 'view/110ec58a-a0f2-4ac4-8393-c866d813b8d1', 'node', (args, cb)->
	console.log("on request node on server")
	obj =
		id: Math.floor((Math.random() * 10) + 1)
		server: "server"
	cb(null, obj)

