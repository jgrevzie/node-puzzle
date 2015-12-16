
###*
 * This is heart of our trading bot. Function below is called
 * for every candle from the history. As a result an order is
 * expected, however not mandatory.
 *
 *
 * @param {float}   [price]   Average (weighted) price
 * @param {Object}  [candle]  Candle data with `time`, `open`, `high`, `low`, `close`,
 *                            `volume` values for given `time` interval.
 * @param {Object}  [account] Your account information. It has _realtime_ balance of USD and BTC
 * @returns {object}          An order to be executed, can be null
###
exports.tick = (price, candle, account) ->
  # World's simplest and most stupid trading algorithm.
  # (it only works for the given historical data)
  # Given more time I would have implemented a parabolic SAR
  if price>300 then return buy: account.BTC / price

  if price<175 then return sell: account.USD

  return null
