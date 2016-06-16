mqtt = require('mqtt')
mqttrpc = require('mqtt-rpc')

settings =
	port: 8080
	reconnectPeriod: 5000

mqttclient = mqtt.connect('ws://test.mosquitto.org', settings)
mqttclient.on "connect", ()->
	console.log "connected !"
	# setInterval job1, 2000
	setInterval job2, 2000

client = mqttrpc.client(mqttclient)
# client.format('json')
client.format('msgpack')

job1 = () ->
	client.callRemote 'view/110ec58a-a0f2-4ac4-8393-c866d813b8d1', 'time', {}, (err, data)->
		console.log data

job2 = () ->
	client.callRemote 'view/110ec58a-a0f2-4ac4-8393-c866d813b8d1', 'node', {}, (err, data)->
		console.log data



	

