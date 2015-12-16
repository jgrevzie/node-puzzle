fs = require 'fs'

exports.ip2long = (ip) ->
  ip = ip.split '.', 4
  return +ip[0] * 16777216 + +ip[1] * 65536 + +ip[2] * 256 + +ip[3]

megaObject = {}
exports.load = ->
  data = fs.readFileSync "#{__dirname}/../data/geo.txt", 'utf8'
  data = data.toString().split '\n'

  for line in data when line
    line = getFields(line)

    saveAddressRange(secondOctet, line) \
      for secondOctet in [line.ipLow[1]..line.ipHigh[1]]

saveAddressRange = (secondOctet, line) ->
  humanIPStart = "#{line.ipLow[0]}.#{secondOctet}"

  megaObject[humanIPStart] || megaObject[humanIPStart]= []
  megaObject[humanIPStart].push
    lowerBound: +line.longIPLow
    upperBound: +line.longIPHigh
    country: line.country
  
exports.lookup = (ip) ->
  return -1 unless ip

  longAddress = this.ip2long ip
  ipStart = firstTwoOctets ip

  return null unless megaObject[ipStart]

  # TODO this would be much faster as a binary search
  for addressRange in megaObject[ipStart]
    return addressRange if longAddress >= addressRange.lowerBound &&
                           longAddress <= addressRange.upperBound

  return null

getFields = (line) ->
  fieldsArray = line.split '\t'
  fieldObject = {}
  fieldObject.longIPLow = fieldsArray[0]
  fieldObject.longIPHigh = fieldsArray[1]
  fieldObject.country = fieldsArray[3]

  ipRange = fieldsArray[2].split(' ')
  fieldObject.ipLow = ipRange[0].split('.')
  fieldObject.ipHigh = ipRange[2].split('.')
  return fieldObject

firstTwoOctets = (ip) ->
  octets = ip.split('.')
  "#{octets[0]}.#{octets[1]}"
