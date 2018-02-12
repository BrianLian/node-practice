os = require 'os'
dgram = require 'dgram'
 
test_receive = (ifaddr)->
  MDNS_PORT = 5353 # OSX refuses app to use port 5353 
  MDNS_ADDRESS = "224.0.0.251"
  s = dgram.createSocket('udp4')
  ver = Number(process.versions.node.split('.')[1])
  
  if ver == 10
    s.on "error", (err)->
      console.log "server error: " + err.stack
      s.close()

    s.on "message", (msg, rinfo)->
      console.log "server got:\n" + msg + "\nfrom " +
        rinfo.address + ":" + rinfo.port

    s.on "listening", ->
      address = s.address()
      console.log "server listeming: " +
        address.address + ":" + address.port

    s.bind MDNS_PORT, ->
      console.log ifaddr
      s.addMembership MDNS_ADDRESS, ifaddr
      #s.setMulticastLoopback true
      #s.setMulticastTTL 128
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
process.stdin.setEncoding("ascii")
vifs = valid_interfaces()

for element in vifs
  console.log "#{vifs.indexOf(element)}. #{element.name} #{element.address}"

console.log 'please select the interface index:'
process.stdin.on 'data', (input) ->
  input = input.replace('\n', '')
  if input < 0 or input >= vifs.length
    console.log "#{input} is not a valid interface"
    return
  test_receive vifs[0].address
