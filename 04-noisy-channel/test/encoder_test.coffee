Encoder = require '../src/encoder'
expect = require 'expect.js'
sinon = require 'sinon'

describe 'Encoder', ->

  enc = new Encoder()

  describe 'encode', ->
    xit 'concats scrambled bits to the original message', ->
      enc.scrambleBits = sinon.stub().returns('hello')
      expect(enc.encode([1, 2, 3, 4])).to.eql Array(enc.N_REPEATS).fill('hello')

  describe 'unscrambleMessage', ->
    xit 'calls unscramble on each frame of the message and returns result', ->
      enc.unscrambleBits = sinon.stub().returns('hello')
      expect(enc.unscrambleMessage([1, 2, 3, 4, 1, 2, 3, 4])).to.
        eql ['hello', 'hello']

    it 'gives original message (repeated) if given an encoded message', ->
      message = [1, 2, 3, 4, 5]
      encoded = enc.encode(message)
      unscrambled = enc.unscrambleMessage(encoded)

      messageRepeated = []
      (messageRepeated = messageRepeated.concat(message)) \
       for [1..enc.N_REPEATS]
      expect(unscrambled).to.eql messageRepeated

  describe 'scramble & unscramble', ->
    it 'cancel each other out', ->
      bits = [1,2,3,4,5]
      scrambled = enc.scrambleBits(bits, 4)
      unscrambled = enc.unscrambleBits(scrambled, 4)
      expect(unscrambled).to.eql bits

      scrambled = enc.scrambleBits(bits, 2)
      unscrambled = enc.unscrambleBits(scrambled, 2)
      expect(unscrambled).to.eql bits

  describe 'averagedBitForIndex', ->
    xit 'gets average across all frames for the bit in position n', ->
      enc.N_REPEATS = 3
      bits = [1, 0, 1, 0, 0, 1]
      expect(enc.averagedBitForIndex(bits, 0)).to.eql 1
      expect(enc.averagedBitForIndex(bits, 1)).to.eql 0
