arp = require 'node-arp'

arp.getMAC '192.168.16.168', (err, mac) ->
  if err is false
    console.log mac
  console.log mac
