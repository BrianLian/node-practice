http = require 'http'

options = 
  uri : 'http://192.168.16.71'
  timeout : 3000
###
req = http.request options, (res) ->
  console.log 'Status: ' + res.statusCode
  console.log 'Status: ' + http.STATUS_CODES[res.statusCode]
  console.log 'Headers: ' + JSON.stringify res.headers
  res.setEncoding 'utf8'
  res.on 'data', (chunk) ->
    console.log 'Body: ' + chunk

req.on 'error', (error) ->
  console.log 'Problem with request: ' + error.message

req.end()
###

###
req = http.get options, (res) ->
  console.log 'Got response: ' + res.statusCode
  res.on 'data', (chunk) ->
    console.log 'Body: ' + chunk
req.on 'error', (e) ->
  console.log 'Got error: ' + e.message
req.setTimeout 3000, () ->
  console.log 'Timeout: '
###

request = require 'request'
request options, (error, response, body) ->
  if error
    console.log 'Got error: ' + error
  else if response.statusCode != 200
    console.log 'Status code: ' + response.statusCode
  else
    console.log 'Body size: ' + body.length
