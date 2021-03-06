snmp = require 'net-snmp'

ipaddr = '192.168.16.189'
options =
  port: 161
  retries: 1
  timeout: 5000
  transport: "udp4"
  trapPort: 162
  version: snmp.Version2C
session = snmp.createSession ipaddr, "public"
session2 = snmp.createSession ipaddr, "public", options

###
snmp.TrapType.
  ColdStart
  WarmStart
  LinkDown
  LinkUp
  AuthenticationFailure
  EgpNeighborLoss
  EnterpriseSpecific
###
session.trap snmp.TrapType.LinkDown, ipaddr, (error) ->
  if error
    console.error error

trapOid = "1.3.6.1.4.1.2000.1"

varbinds =
    oid: "1.3.6.1.4.1.2000.2",
    type: snmp.ObjectType.OctetString,
    value: "Hardware health status changed",
    oid: "1.3.6.1.4.1.2000.3",
    type: snmp.ObjectType.OctetString,
    value: "status-error"

session2.trap trapOid, varbinds, (error) ->
  if error
    console.error error