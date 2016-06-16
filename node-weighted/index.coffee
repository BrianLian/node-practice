rwc = require 'random-weighted-choice'
table = [
  { weight: 8, id: "system" }
  { weight: 1, id: "vlan" }
  { weight: 1, id: "ring" }
  { weight: 4, id: "stp" }
  { weight: 1, id: "multicast" }
]
# choosenItem = rwc(table)
# choosenUnlikely = rwc(table, 100)
# choosenDeterministically = rwc(table, 0)

job = () ->
  console.log rwc(table)
  # console.log rwc(table, 100)
  # console.log rwc(table, 0)

setInterval job, 1000
