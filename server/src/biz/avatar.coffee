fs = require 'fs'
path = require 'path'
Base = require './base'

distDir = require('../configure').conver.distDir

class Avatar extends Base
  constructor: ->
  get: (req, resp, next)->
    id = req.params.id
    filePath = path.join distDir, id
    resp.sendFile filePath, (err)->
      if err
        console.log err
        resp.status(err.status).end()

module.exports = new Avatar()