snmp = require 'snmp-native'
oids =  ['.1.3.6.1.4.1.2021.10.1.3.1',
         '.1.3.6.1.4.1.2021.10.1.3.2',
         '.1.3.6.1.4.1.2021.10.1.3.3']
oids2 = ['.1.3.6.1.4.1.37072.302.2.3.1.1.0']
session = new snmp.Session { host: '192.168.16.205' }
session.getAll { oids: oids}, (error, varbinds) ->
    if error 
        console.log error
    else
        varbinds.forEach (vb) ->
            console.log vb.oid
            console.log vb.value
            console.log vb.type
arp = require 'node-arp'
arp.getMAC '192.168.16.205', (error, mac) ->
    if not error
        console.log mac
