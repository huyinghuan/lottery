var service = {};
var employeeAPI = "/api/employee";
var awardCountAPI = "/api/award_count"
service.getEmployeeList = function(cb){
  $.get(employeeAPI, function(data){
    cb(data)
  });
};

service.postEmployeeList = function(data, cb){
  var postData = {
    winners: data.join(",")
  };
  $.post(employeeAPI, postData, function(result){
    cb && cb(result);
  });
};

//获取中奖人数
service.getWinnerCount = function(cb){
  $.get(awardCountAPI, function(result){
    cb(+result)
  })
};