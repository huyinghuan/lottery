path = require 'path'

dbPath = path.join process.cwd(), "db.sqlite"
schemaPath = path.join __dirname, 'schema'

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
