Base = require './base'
class OtherWinnerCount extends Base
  constructor: ->

  get: (req, resp, next)->
    console.log(req.params.count)
    global.otherWinnerNunber = +req.params.count
    resp.send("success")

module.exports = new OtherWinnerCount();