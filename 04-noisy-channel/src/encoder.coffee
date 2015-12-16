SeededShuffle = require('seededshuffle')

module.exports = class Encoder

  constructor: ->
    @N_REPEATS = 30

  # This approach is nice and simple.
  # It can be made more robust simply by increasing N_REPEATS.
  # Given more time I would have used a Hamming (7, 4) encoding.
  # My approach is slow and wastes bandwidth.

  encode: (bits) ->
    encoded = []
    encoded = (encoded.concat( @scrambleBits(bits, i))) \
      for i in [1..@N_REPEATS]
    encoded

  decode: (bits) ->
    unscrambledMessage = @unscrambleMessage(bits)
    @getAverageBits(unscrambledMessage)

  scrambleBits: (bits, seed) ->
    SeededShuffle.shuffle(bits.slice(), seed)

  unscrambleBits: (bits, seed) ->
    # Using a random shuffle helps with 'noise' that occurs at regular intervals
    # (ie isn't really noise :)
    SeededShuffle.unshuffle(bits.slice(), seed)

  unscrambleMessage: (bits) ->
    unscrambledMessage = Array(bits.length)
    @unscrambleFrame(bits, unscrambledMessage, frameId) \
      for frameId in [0...@N_REPEATS]

    unscrambledMessage

  getAverageBits: (bits) ->
    # TODO: method
    frameSize = bits.length / @N_REPEATS
    averagedMessage = Array(frameSize)
    (averagedMessage[index] = @averagedBitForIndex(bits, index)) \
      for index in [0...frameSize]

    averagedMessage

  averagedBitForIndex: (bits, index) ->
    frameSize = bits.length / @N_REPEATS
    sum = 0
    sum += bits[i] for i in [index...bits.length] by frameSize
    !!Math.round( sum / @N_REPEATS)

  unscrambleFrame: (scrambledMessage, unscrambledMessage, frameId) ->
    frameSize = scrambledMessage.length / @N_REPEATS
    startBit = frameId*frameSize
    endBit = startBit + frameSize
    unscrambledMessage[startBit...endBit] =
      @unscrambleBits(scrambledMessage[startBit...endBit], frameId+1)
