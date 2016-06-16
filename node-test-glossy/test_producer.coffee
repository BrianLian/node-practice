###
'kern':   0
'user':   1
'mail':   2
'daemon': 3
'auth':   4
'syslog': 5
'lpr':    6
'news':   7
'uucp':   8
'clock':  9
'sec':    10
'ftp':    11
'ntp':    12
'audit':  13
'alert':  14
'clock':  15
'local0': 16
'local1': 17
'local2': 18
'local3': 19
'local4': 20
'local5': 21
'local6': 22
'local7': 23
###
###
'emerg': 0
'emergency': 0
'alert': 1
'crit': 2
'critical': 2
'err': 3
'error': 3
'warn': 4
'warning': 4
'notice': 5
'info': 6
'information': 6
'informational': 6
'debug':  7
###
syslog_producer = require('glossy').Produce;
syslog_producer = new syslog_producer({ type: 'RFC3164', facility: 'daemon', appName: 'netmon-agent' });

msg = syslog_producer.produce
    severity: 'notice'
    host: 'localhost'
    pid: process.pid
    date: Date()
    message: 'message'

console.log msg
