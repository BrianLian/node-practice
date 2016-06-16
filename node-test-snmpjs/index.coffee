snmp = require 'snmpjs'
util = require 'util'

result = []
#log = new logger { name: 'snmpd', level: 'info' }

trapd = snmp.createTrapListener()

trapd.on 'trap', (msg) ->
    #console.log snmp.message.serializer(msg)
    console.log '====Trap===='
    #console.log util.inspect(msg.version, false, null, true)
    #console.log util.inspect(msg.community, false, null, true)
    #console.log util.inspect(msg.pdu, false, null, true)
    if msg.version is 0
      now = new Date()
      console.log now.toISOString()
      console.log "Version: ", msg.version
      console.log "Community: ", msg.community
      console.log "OID: ", msg.pdu.enterprise
      console.log "Agent: ", msg.pdu.agent_addr
      console.log msg.pdu.op
      console.log msg.pdu.generic_trap
      console.log msg.pdu.specific_trap
      console.log snmp.pdu.strop msg.pdu.op
      console.log snmp.pdu.strtrap msg.pdu.generic_trap
    else if msg.version is 1
      console.log snmp.message.serializer(msg)
      now = new Date()
      console.log now.toISOString()
      console.log "Version: ", msg.version
      console.log "Community: ", msg.community.toString()
      console.log msg.pdu.op
      console.log snmp.pdu.strop msg.pdu.op
      console.log msg.pdu.request_id
      console.log msg.pdu.error_status
      console.log msg.pdu.error_index
      for item in msg.pdu.varbinds
        console.log '====item===='
        console.log item.oid
        console.log item.data.typename
        console.log snmp.data.isTypeRegistered item.data.typename
        console.log item.data.tag
        console.log snmp.data.isTagRegistered item.data.tag
        console.log "Value, #{item.data.value}"
      #console.log msg.pdu.specific_trap

      #console.log snmp.pdu.strtrap msg.pdu.generic_trap

trapd.bind {family: 'udp4', port: 162}

trapd.on 'error', (err) ->
  console.log "on error"
  console.log err

setTimeout () ->
  trapd.close()
, 20000



