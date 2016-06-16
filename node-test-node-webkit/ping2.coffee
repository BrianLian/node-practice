class ICMPCheckerService
  nodesArr = []
  intervalObject = null
  chgCallback = null
  isWin = ""
  delay = 5000
  ping = null
  session = null
  constructor: (ipList, callback) ->
    console.log '[Info] ICMPCheckerService constructor'
    isWin = /^win/.test(process.platform)
    ping = require 'ping'
    for ip in ipList
      obj =
        ipAddr: ip
        isAlive: true
      nodesArr.push obj
    chgCallback = callback

  startChecker:  () ->
    if intervalObject isnt null
      clearInterval intervalObject
      intervalObject = null
    job = () ->
      nodesArr.forEach (node) ->
        ping.sys.probe node.ipAddr, (isAlive) ->
          findNode = findNodeByIpAddr node.ipAddr
          if findNode and findNode.isAlive isnt isAlive
            findNode.isAlive = isAlive
            chgCallback node.ipAddr, isAlive

    intervalObject = setInterval job, delay

  stopChecker: () ->
    if intervalObject isnt null
      clearInterval intervalObject
      intervalObject = null

  addIPAddr: (ip) ->
    console.log 'addIPAddr'
    console.log 'Not support yet'

  removeIPAddr: (ip) ->
    console.log 'removeIPAddr'
    console.log 'Not support yet'

  setInterval: (intervalTime) ->
    delay = intervalTime
    stopChecker()
    startChecker()

  findNodeByIpAddr = (ip) ->
    return n for n in nodesArr when n.ipAddr is ip
    return null

exports.ICMPCheckerService = ICMPCheckerService