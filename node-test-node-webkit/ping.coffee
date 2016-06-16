class ICMPCheckerService
  nodesArr = []
  intervalObject = null
  chgCallback = null
  isWin = ""
  delay = 5000

  constructor: (ipList, callback) ->
    console.log '[Info] ICMPCheckerService constructor'
    isWin = /^win/.test(process.platform)
    console.log process.platform + " " + isWin
    for ip in ipList
      obj =
        ipAddr: ip
        isAlive: true
      nodesArr.push obj
    chgCallback = callback

  startChecker:  (callback) ->
    if intervalObject isnt null
      clearInterval intervalObject
      intervalObject = null
    job = () ->
      console.log "In Timer"
      for n in nodesArr
        ip = n.ipAddr
        exec = require('child_process').exec
        puts = (err, stdout, stderr) ->
          if err isnt null
            console.log '[error] ' + err
          else
            chgCallback ip, stdout
        child = exec "ping -c 1 #{ip}", puts
        console.log "[Info] child = #{child}"
        console.log child
    intervalObject = setInterval job, delay

  stopChecker: () ->
    if intervalObject isnt null
      clearInterval intervalObject
      intervalObject = null

  addIPAddr: (ip) ->
    console.log 'addIPAddr'

  removeIPAddr: (ip) ->
    console.log 'removeIPAddr'

  findNodeByIpAddr: (ip) ->
    return n for n in nodesArr where n.ipAddr is ip
    return null

exports.ICMPCheckerService = ICMPCheckerService