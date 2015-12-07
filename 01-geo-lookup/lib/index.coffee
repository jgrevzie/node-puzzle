fs = require 'fs'


GEO_FIELD_MIN = 0
GEO_FIELD_MAX = 1
GEO_FIELD_IP_RANGE = 2
GEO_FIELD_COUNTRY = 3

exports.ip2long = (ip) ->
  ip = ip.split '.', 4
  return +ip[0] * 16777216 + +ip[1] * 65536 + +ip[2] * 256 + +ip[3]

megaObject = {}
exports.load = ->
  data = fs.readFileSync "#{__dirname}/../data/geo.txt", 'utf8'
  data = data.toString().split '\n'

  for line in data when line
    line = line.split '\t'
    humanIPStart = firstTwoOctets(line[GEO_FIELD_IP_RANGE])

    megaObject[humanIPStart] || megaObject[humanIPStart]= []
    megaObject[humanIPStart].push
      lowerBound: +line[GEO_FIELD_MIN]
      upperBound: +line[GEO_FIELD_MAX]
      country: line[GEO_FIELD_COUNTRY]

exports.lookup = (ip) ->
  return -1 unless ip

  longAddress = this.ip2long ip
  ipStart = firstTwoOctets ip

  return null unless megaObject[ipStart]

  for addressRange in megaObject[ipStart]
    return addressRange if longAddress >= addressRange.lowerBound &&
                           longAddress <= addressRange.upperBound

  return null

firstTwoOctets = (ipRange) ->
  ipRange = ipRange.split(' ')
  firstIP = ipRange[0].split('.')
  "#{firstIP[0]}.#{firstIP[1]}"
