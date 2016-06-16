var syslogProducer = require('glossy').Produce; // or wherever glossy lives
var msg = syslogProducer.produce({
    facility: 'ntp',
    severity: 'info',
    host: 'localhost',
    date: new Date(Date()),
    message: 'Lunch Time!'
}, function(syslogMsg){
    console.log(syslogMsg);
});