Bean = require('./bean/employee')
Award = require('./bean/award')
bean = new Bean()
award = new Award()

clearAll = ->
  bean.clearAll().then((r)-> console.log r)
  award.clearAll().then((r)-> console.log r)

clearAll()