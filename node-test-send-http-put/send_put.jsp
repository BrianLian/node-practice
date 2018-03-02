var http = require('http');

var bodyString = JSON.stringify({
    mute: false
});

var headers = {
    'Content-Type': 'application/json',
    'Content-Length': bodyString.length
};

var options = {
    host: '192.168.17.111',
    path: '/r/matrix/extender/txA/mute',
    port: 80,
    method: 'PUT',
    headers: headers
};


var callback = function(response) {
var str = '';

response.on('data', function(chunk) {
	str += chunk;
});

response.on('end', function() {
		console.log("End");
		console.log(str);
	});
};

http.request(options, callback).write(bodyString);

