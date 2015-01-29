path = require 'path'
express = require 'express'
bodyParser = require 'body-parser'
multer = require 'multer'

Waterpit = require('water-pit').Waterpit

RouterMap = require './route-map'
router = express.Router()
new Waterpit(router, RouterMap)

global.otherWinnerNunber = 1;

app = express()

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))
app.use(multer())

app.use(express.static(path.join(process.cwd(), 'client')))
app.use('/', router)
app.listen(3000)

