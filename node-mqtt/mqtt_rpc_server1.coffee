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

server.provide 'RPC/view', 'time', (args, cb)->
	console.log("on request time on server 1")
	cb(null, new Date())

server.provide 'RPC/view', 'node', (args, cb)->
	console.log("on request node on server1")
	obj =
		id: Math.floor((Math.random() * 10) + 1)
		server: "server1"
	cb(null, obj)

