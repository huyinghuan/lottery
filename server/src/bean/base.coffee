Coal = require 'coal'
dbConf = require '../configure'
_coal = new Coal(dbConf.db, dbConf.develop)
class Base
  constructor: ->
    @conn = _coal
    @init()

  init: ->
    throw new Error('cannot find table') if @tableName is null
    @table = @conn.Model(@tableName, dbConf.develop)

module.exports = Base