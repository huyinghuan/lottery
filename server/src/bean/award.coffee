async = require 'async'
Base = require './base'
Employee = require './employee'
employee = new Employee()

class Award extends Base
  constructor: ->
    @tableName = "award"
    super

  save: (award)->
    award.status = 0
    @table.save(award)

  clearAll: ->
    @table.table().where(1, 1).del()

  getAll: (next)->
    self = @
    queue = []
    queue.push((cb)->
      self.table.find(["*"]).then((r)->
        #获取获奖者名单
        cb(null, r)
      )
    )
    queue.push((winnerList, cb)->
      self.getWinnerInfo(winnerList, cb)
    )
    async.waterfall(queue, (err, result)->
      next(err, result)
    )

  #获取获奖者名单
  getWinnerInfo: (winnerList, next)->
    index = 0
    winner = null
    async.whilst(()->
      winner = winnerList[index]
      return winner
    , (cb)->
      winnersIdList = winner.winners.split(",")
      employee.getList(winnersIdList).then((result)->
        winnerList[index].winners = result
        index += 1
        cb()
      )
    , (err)->
      next(err, winnerList)
    )

  #根据id 获取中间名单
  getEmployeeList: (id, next)->
    @table.find(["*"], [{id: id}]).then((result)->
      winners = result[0]?.winners
      winners = winners or ""
      next and next(winners.split(','))
    )


  setWinnerFlag: (id, flag = 1, next)->
    @table.update({status: flag}, ['id', '=', id])


module.exports = Award