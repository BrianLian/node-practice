// Generated by CoffeeScript 1.8.0
var option, request, url, url_obj, url_str;

request = require('request');

url = require('url');

url_obj = {
  protocol: 'http',
  host: '192.168.16.81'
};

url_str = url.format(url_obj);

option = {
  url: url_str,
  timeout: 4000
};

request(option, function(error, response, body) {
  if ((error == null) && response.statusCode === 200) {
    console.log(response.length);
    return console.log(body.length);
  } else {
    return console.log(error.Error);
  }
});
