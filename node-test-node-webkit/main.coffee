doSomething = () ->
  ipList = ["192.168.16.205", "192.168.16.82", "192.168.16.83"]
  chgCallback = (ip, isAlive) ->
    console.log "[Info] ip = #{ip}, isAlive = #{isAlive}"
  ping = require('./ping2')
  ICMPChecker  = new ping.ICMPCheckerService(ipList, chgCallback)
  ICMPChecker.startChecker()


window.doSomething = doSomething