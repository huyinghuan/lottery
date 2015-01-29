Base = require './base'
class Employee extends Base
  constructor: ->
    @tableName = "employee"
    super

  #获取所有未中奖的名单
  getAll: (count)->
    @table.find(["id", "name", "avatar"], [{status: 0}])

  #剔除已中奖名单
  setWinnerFlag: (winnersId, flag = 1)->
    winnersId = [].concat(winnersId)
    sql = @table.table().update(status: flag).whereIn('id', winnersId)
    console.log sql.toString()
    sql

  #根据id获取姓名列表
  getList: (winnersId)->
    sql = @table.table().select("name", "avatar").whereIn('id', winnersId)
    console.log sql.toString()
    sql

  #0 未中奖人员， 1 已中奖人员
  save: (employee)->
    employee.status = 0 if not employee.status
    @table.save(employee)

  clearAll: ->
    @table.table().where(1, 1).del()

  resetAll: ->
    @table.table().update({status: 0}).where('id', '>', 0)

module.exports =  Employee