module.exports = class Encoder
  encode: (bits) ->
    # TODO: variable # of repeats
    console.log('encode', bits)

    encoded = this.rotateMessage(
      bits.concat(bits).concat(bits).concat(bits).concat(bits).concat(bits),
      1)
    console.log('encoded', encoded)
    encoded

  decode: (bits) ->
    # TODO: variable # of repeats
    console.log('decode', bits)

    bits = this.rotateMessage(bits, -1)
    console.log('unrotated', bits)

    originalSize = bits.length / 6
    decodedBits = (this.averageBitForPostion(i, bits) for i in [0..originalSize-1])
    #console.log('decoded', decodedBits)
    decodedBits

  averageBitForPostion: (i, bits) ->
    originalSize = bits.length / 6
    console.log('averaging',      bits[i],
      bits[i+originalSize] ,
          bits[i+2*originalSize] ,
          bits[i+3*originalSize] ,
          bits[i+4*originalSize] ,
          bits[i+5*originalSize])
    result = !!Math.round( (bits[i] +
      bits[i+originalSize] +
      bits[i+2*originalSize] +
      bits[i+3*originalSize] +
      bits[i+4*originalSize] +
      bits[i+5*originalSize])/5 )

    console.log('average = ', result)
    result

  rotate: (bits, amount) ->
    Array.prototype.unshift.apply(bits, bits.splice(amount, bits.length))
    bits

  rotateMessage: (bits, amount) ->
    origSize = bits.length / 6
    delta = if amount>0 then 1 else -1
    bits[0..origSize-1].
      concat(this.rotate(bits[origSize..(2*origSize-1)], amount)).
      concat(this.rotate(bits[2*origSize..(3*origSize-1)], amount+=delta)).
      concat(this.rotate(bits[3*origSize..(4*origSize-1)], amount+=delta)).
      concat(this.rotate(bits[4*origSize..(5*origSize-1)], amount+=delta)).
      concat(this.rotate(bits[5*origSize..(6*origSize-1)], amount+=delta))
