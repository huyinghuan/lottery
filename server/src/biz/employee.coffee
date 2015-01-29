Base = require './base'
Bean = require '../bean/employee'
Award = require '../bean/award'
_async = require 'async'
_ = require 'lodash'
award = new Award()
bean = new Bean()

class Employee extends Base
  get: (req, resp, next)->
    bean.getAll().then((r)->
      resp.send(r)
    ).catch((error)->
      console.log(error)
      resp.send([])
    )

  post: (req, resp, next)->

    winners = req.body.winners.split(',')

    queue = []

    #保存中奖者信息
    queue.push((cb)->
      award.save(req.body).then(-> cb()).catch((e)-> cb(e))
    )
    #剔出候选队伍
    queue.push((cb)->
      bean.setWinnerFlag(winners).then(-> cb()).catch((e)-> cb(e))
    )
    #获取中奖者名单
    queue.push((cb)->
      bean.getList(winners).then((r)-> resp.send(r)).catch((e)-> cb(e))
    )

    _async.series(queue, (error, results)->
      console.log results
      resp.status(500).send('后台出错') if(error)
    )



module.exports = new Employee()