// Generated by CoffeeScript 1.10.0
(function() {
  var job, rwc, table;

  rwc = require('random-weighted-choice');

  table = [
    {
      weight: 8,
      id: "system"
    }, {
      weight: 1,
      id: "vlan"
    }, {
      weight: 1,
      id: "ring"
    }, {
      weight: 4,
      id: "stp"
    }, {
      weight: 1,
      id: "multicast"
    }
  ];

  job = function() {
    return console.log(rwc(table));
  };

  setInterval(job, 1000);

}).call(this);
