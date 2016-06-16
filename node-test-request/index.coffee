request = require 'request'
url = require 'url'

url_obj =
  protocol: 'http'
  host: '192.168.16.81'
url_str = url.format url_obj

option =
  url: url_str
  timeout: 4000

request option, (error, response, body) ->
  if not error? and response.statusCode == 200
    console.log response.length
    console.log body.length
  else
    console.log error.Error
