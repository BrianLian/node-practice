// Generated by CoffeeScript 1.8.0
var result, snmp, trapd, util;

snmp = require('snmpjs');

util = require('util');

result = [];

trapd = snmp.createTrapListener();

trapd.on('trap', function(msg) {
  var item, now, _i, _len, _ref, _results;
  console.log('====Trap====');
  if (msg.version === 0) {
    now = new Date();
    console.log(now.toISOString());
    console.log("Version: ", msg.version);
    console.log("Community: ", msg.community);
    console.log("OID: ", msg.pdu.enterprise);
    console.log("Agent: ", msg.pdu.agent_addr);
    console.log(msg.pdu.op);
    console.log(msg.pdu.generic_trap);
    console.log(msg.pdu.specific_trap);
    console.log(snmp.pdu.strop(msg.pdu.op));
    return console.log(snmp.pdu.strtrap(msg.pdu.generic_trap));
  } else if (msg.version === 1) {
    console.log(snmp.message.serializer(msg));
    now = new Date();
    console.log(now.toISOString());
    console.log("Version: ", msg.version);
    console.log("Community: ", msg.community.toString());
    console.log(msg.pdu.op);
    console.log(snmp.pdu.strop(msg.pdu.op));
    console.log(msg.pdu.request_id);
    console.log(msg.pdu.error_status);
    console.log(msg.pdu.error_index);
    _ref = msg.pdu.varbinds;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      item = _ref[_i];
      console.log('====item====');
      console.log(item.oid);
      console.log(item.data.typename);
      console.log(snmp.data.isTypeRegistered(item.data.typename));
      console.log(item.data.tag);
      console.log(snmp.data.isTagRegistered(item.data.tag));
      _results.push(console.log("Value, " + item.data.value));
    }
    return _results;
  }
});

trapd.bind({
  family: 'udp4',
  port: 162
});

trapd.on('error', function(err) {
  console.log("on error");
  return console.log(err);
});

setTimeout(function() {
  return trapd.close();
}, 20000);
