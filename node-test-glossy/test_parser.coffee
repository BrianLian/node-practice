syslogParser = require('glossy').Parse
dgram  = require("dgram")
server = dgram.createSocket("udp4")

server.on "message", (rawMessage, rinfo) ->
  str_msg = rawMessage.toString()
  #str_msg = str_msg.replace 'NaN', 30
  #str_msg = '<30>Oct 9 22:33:20 hlfedora auditd[1787]: The audit daemon is exiting.'
  #str_msg = '<33>Dec  3 16:39:34 switch71 none[4804]:Wed Dec 03 2014 16:39:34 GMT+0800 (CST)\t192.168.16.71\tauth_user fail , user admin cant login'
  console.log rawMessage
  console.log rinfo.address
  console.log rinfo.port
  syslogParser.parse str_msg, (parsedMessage) ->
    console.log parsedMessage
    #console.log parsedMessage.host + ' - ' + parsedMessage.message

server.on "listening", () ->
  address = server.address();
  console.log "Server now listening at " + address.address + ":" + address.port

server.bind 514

#<NaN>Dec  3 16:39:34 switch71 none[4804]:Wed Dec 03 2014 16:39:34 GMT+0800 (CST)\t192.168.16.71\tauth_user fail , user admin cant login
#<30>Oct 9 22:33:20 hlfedora auditd[1787]: The audit daemon is exiting.
