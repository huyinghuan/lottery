Bean = require('./bean/employee')
Award = require('./bean/award')
bean = new Bean()
award = new Award()

resetAll = ->
  bean.resetAll().then((r)-> console.log r)
  award.clearAll().then((r)-> console.log r)

resetAll()