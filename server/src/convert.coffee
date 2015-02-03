_thumbnail = require 'thumbnail-psd'
_fs = require 'fs'
_fse = require 'fs-extra'
_path = require 'path'
_uuid = require 'node-uuid'
_async = require 'async'

_Bean = require './bean/employee'

configure = require('./configure')
_config = configure.conver


sourceDir = _config.sourceDir
distDir = _config.distDir
bean = new _Bean()

saveBean = (fileName, avatar, cb)->
  name = fileName.replace(/\.JPG|\.jpg|\.png|\.PNG|\.tif|\.jpeg|\.TIF/, '')
  bean.save({
    name: name
    avatar: avatar
  })
  .then((r)->
    console.log "#{name} save success"
    cb()
  )
  .catch((e)->
    console.error("#{fileName} save fail!")
    cb()
  )

covert = (fileName, cb)->
  distFileName = "#{_uuid.v4()}.JPG"
  sourcePath = _path.join(sourceDir, fileName)
  distPath =  _path.join(distDir, distFileName)
  _fse.copySync(sourcePath, distPath)
  saveBean(fileName, distFileName, cb)
#  _thumbnail(sourcePath, distPath, {width: 300, height: 300},(error)->
#    status = if error then 'Fail' else 'Success'
#    console.log "covert #{fileName} to #{distFileName} #{status}"
#    if not error
#      saveBean(fileName, distFileName, cb)
#    else
#      console.log error
#      cb()
#  )

thum = ()->
  files = _fs.readdirSync sourceDir
  fileName = ""
  _async.whilst(
    ()->
      fileName = files.shift()
      return fileName
  , (cb)->
    covert(fileName, cb)
  , ()->
  )


if configure.isTestEnviroment
  require('./test-assets/add-test-data')
else
  thum()
