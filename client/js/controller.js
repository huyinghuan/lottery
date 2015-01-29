;(function(){
  'use strict';
  angular.module('lottery', [])
  .factory('AwardService',['$http', function($http){
    var service = {};
    service.getAwardList = function(cb){
      $http.get('/api/award')
        .success(function(data){console.log(data);cb && cb(data)})
        .error(function(data, status){alert("Server error!");console.log(status)})
    };

    service.cancelAwardList = function(id, cb){
      $http.delete('/api/award/'+id).success(function(){
        cb && cb()
      })
    };

    service.resetAwardList = function(id, cb){
      $http.put('/api/award/' + id).success(function(){
        cb && cb();
      })
    };

    return service;

  }])
  .controller('AwardCtrl', ['$scope', 'AwardService', function($scope, AwardService) {
      var init = function(){
        AwardService.getAwardList(function(data){
          $scope.list = data;
        });
      };
      init();
      $scope.getNames = function(list){
        var queue = [];
        for(var index = 0, length = list.length; index < length; index++){
          queue.push(list[index].name)
        }
        return queue.join(',')
      };

      $scope.cancel = function(id){
        var flag = confirm("确定撤销操作？ 这会影响抽奖进程！");
        if(!flag) return;
        AwardService.cancelAwardList(id, function(){
          init();
        })
      };
      $scope.recover = function(id){
        var flag = confirm("确定恢复操作？ 这会影响抽奖进程！");
        if(!flag) return;
        AwardService.resetAwardList(id, function(){
          init();
        })
      };
      $scope.getStatus = function(status){
        return status === 0 ? "有效" : "无效"
      };
  }]);
})();