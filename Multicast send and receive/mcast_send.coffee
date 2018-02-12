os = require 'os'
dgram = require 'dgram'
 
test_send = (ifaddr)->
  MDNS_PORT = 5353 # OSX refuses app to use port 5353 
  MDNS_ADDRESS = "224.0.0.251"
  s = dgram.createSocket('udp4')
  ver = Number(process.versions.node.split('.')[1])
  
  if ver == 10
    sendData = 'This is brian.'
    console.log ifaddr
    s.bind MDNS_PORT, ifaddr, ->
      s.addMembership MDNS_ADDRESS, ifaddr
      s.send new Buffer(sendData), 0, sendData.length, MDNS_PORT, MDNS_ADDRESS, (err,bytes) ->
        console.log 'send err=', err
        console.log 'send bytes=', bytes
  else
    console.log "unsupported node version:", ver
    
valid_interfaces = ->
  vifs=[]
  for ifnm, ifaddrs of os.networkInterfaces()
    for a in ifaddrs
       continue if a.family is 'IPv6' or a.internal is true
       vifs.push name:ifnm, address:a.address
  vifs

process.stdin.resume()
process.stdin.setEncoding("utf8")
vifs = valid_interfaces()

for element in vifs
  console.log "#{vifs.indexOf(element)}. #{element.name} #{element.address}"
process.stdin.on 'data', (input) ->
  input = input.replace('\n', '')
  if input < 0 or input >= vifs.length
    console.log "#{input} is not a valid interface"
    return
  test_send vifs[0]['address']
