path = require 'path'

dbPath = path.join process.cwd(), "db.sqlite"
schemaPath = path.join __dirname, 'schema'

#测试环境.正式环境请设置为 false
exports.isTestEnviroment = true
exports.testAvatar = path.join __dirname, 'test-assets/a.jpg'

exports.db =
  database:
    client: 'sqlite3'
    connection: filename: dbPath
  schema: schemaPath

exports.develop = true

#转换照片的配置
exports.conver =
  sourceDir: "/home/ec/dumps/photos"
  distDir: "/home/ec/dumps/dist"

#每轮抽奖的数量
exports.winnersCount = [40, 20, 20, 20, 20, 20, 20, 40, 1, 1]
#每轮抽奖的奖品代号 和前台奖品的代号保持一直
exports.winnersProductlist = [
  [6,2,1,3]
  [5,1]
  [6,3]
  [6,3]
  [5,1]
  [5,1]
  [5,1]
  [6,2,1,3]
]