path = require 'path'

module.exports =
  cwd: path.join __dirname, 'biz'
  baseUrl: '/api'
  map: [
      {
        path: '/employee'
        biz: 'employee'
        methods: DELETE: false
      },{
        path: '/avatar/:id'
        biz: 'avatar'
      },{
        path: '/award'
        biz: 'award'
        methods: GET: "getAll"
      },{
        path: '/award_count'
        biz: 'award'
        methods: GET: "getWinnerCount"
      },{
        path: '/award/:id'
        biz: 'award'
      },{
        path: '/otherWinnnerCount/:count'
        biz: 'otherWinnerCount'
      }
  ]