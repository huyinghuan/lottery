async = require 'async'
Base = require './base'
Employee = require '../bean/employee'
Bean = require '../bean/award'

employee = new Employee()
bean = new Bean()

winnersCountList = require('../configure').winnersCount

class Award extends Base
  getAll: (req, resp, next)->
    bean.getAll((error, result)->
      if error
        resp.status(500).send("crash")
      else
        resp.send(result)
    )

  getWinnerCount: (req, resp, next)->
    self = @
    sql = bean.table.table().count('*').where("status", 0)
    sql.then((result)->
      count = self.calWinnerCount(result[0])
      resp.send("#{count}")
    )

  calWinnerCount: (item)->
    count = 0
    for key, value of item
      count = value
      break

    length = winnersCountList[count]
    if not length
      length = global.otherWinnerNunber or 1

    return length

  delete: (req, resp, next)->
    id = req.params.id
    queue = []
    #获取中奖的id
    queue.push((cb)->
      bean.getEmployeeList(id, (winners)->
        cb(null, winners)
      )
    )
    #批量更新中奖者的状态 未中奖
    queue.push((winners, cb)->
      employee.setWinnerFlag(winners, 0).then(()->
        cb()
      )
    )
    #更新中奖名单状态 失效
    queue.push((cb)->
      bean.setWinnerFlag(id, 1).then(cb)
    )
    async.waterfall(queue, (err, result)->
      resp.send("success")
    )

  put: (req, resp, next)->
    id = req.params.id
    queue = []
    #获取中奖的id
    queue.push((cb)->
      bean.getEmployeeList(id, (winners)->
        cb(null, winners)
      )
    )
    #批量更新中奖者的状态 已中奖
    queue.push((winners, cb)->
      employee.setWinnerFlag(winners, 1).then(()->
        cb()
      )
    )
    #更新中奖名单状态 有效
    queue.push((cb)->
      bean.setWinnerFlag(id, 0).then(cb)
    )
    async.waterfall(queue, (err, result)->
      resp.send("123")
    )


module.exports = new Award()
