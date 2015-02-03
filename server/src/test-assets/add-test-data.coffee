_uuid = require 'node-uuid'
_Bean = require '../bean/employee'
bean = new _Bean()
saveBean = (name, avatar)->
  bean.save({
    name: name
    avatar: avatar
  })
  .then((r)->
    console.log "#{name} save success"
  )
  .catch((e)->
    console.log(e)
    console.error("#{name} save fail!")
  )

addData = ()->
  saveBean("test_#{index}", "a.jpg") for index in [0..500]

setTimeout(addData, 1000)
