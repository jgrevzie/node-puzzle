Encoder = require '../src/encoder'
expect = require 'expect.js'

describe 'Encoder', ->
  describe 'rotate', ->
    it 'rotates the array by the given number of places', ->
      expect(new Encoder().rotate([1, 2, 3, 4], 1)).to.eql [2, 3, 4, 1]

    it "will rotate the array backwards with negative argument", ->
      expect(new Encoder().rotate([1, 2, 3, 4], -1)).to.eql [4, 1, 2, 3]

  describe 'rotateMessage', ->
    it 'returns message with chunks rotated', ->
      enc = new Encoder()
      bits = [1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4]
      expect(enc.rotateMessage(bits, 1)).to.
        eql [1, 2, 3, 4, 2, 3, 4, 1, 3, 4, 1, 2, 4, 1, 2, 3, 1, 2, 3, 4 ]

    it 'returns message with chunks unrotated', ->
      enc = new Encoder()
      bits = [1, 2, 3, 4, 2, 3, 4, 1, 3, 4, 1, 2, 4, 1, 2, 3, 1, 2, 3, 4]
      expect(enc.rotateMessage(bits, -1)).to.
        eql [1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4]
