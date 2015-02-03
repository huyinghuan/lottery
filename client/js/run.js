'use strick';
var queue = [];
var preselectedQueue = []; //暂停时位于屏幕中央的名单备选
var GLOBAL = true;
var winnerCount = 0;
var result20Template = Handlebars.compile($('#result20').html());
var result40Template = Handlebars.compile($('#result40').html());
var resultOtherTemplate = Handlebars.compile($('#resultOther').html());
var resultTVTemplate = Handlebars.compile($('#resultTV').html());

var bodyWidth= 1440;
var bodyHeight = 900;
var picHeight = 135;
var picWidth = 335;

var winnerDisplayTimeInterval = 50; //头像气球飘出来的时间间隔 单位毫秒

//初始化变量 暂停使用
var init = function(cb){
  document.getElementById("vessel").innerHTML = "";
  document.getElementById("vessel").style.display = "block";
  queue = [];
  preselectedQueue = [];
  winnerCount = 0;
  GLOBAL = true;
  $("#modal-window div").hide();
  $("#mask").hide();
  readLottery(cb);
};

//获取职员数据
var getEmployeeList = function(cb){
  service.getEmployeeList(function(data){
    cb(null, data)
  });
};

//生成元素
var generateBlock = function(list, cb){
  for(var i = 0, length = list.length; i < length; i++){
    document.getElementById("vessel").appendChild(utils.generateBlockItem(list[i]));
    queue.push(list[i].id)
  }
  cb()
};

//获取本次中奖人数
var getWinnnerCount = function(cb){
  service.getWinnerCount(function(count){
    winnerCount = count;
    cb()
  })
};

//准备抽奖
var readLottery = function(cb){
  var tasksQueue = [getEmployeeList, generateBlock, getWinnnerCount];
  async.waterfall(tasksQueue, function(){cb && cb()})
};

//动画
var animation = function(id) {
  var domId = "#" + id;
  var itemId = id.replace("item_", "");
  $(domId).addClass("doingAnimate").animate({top: "-="+(bodyHeight + picHeight)+"px"}, {
    duration: 3000,
    complete: function () {
      $(domId).css("top",0+"px");
      $(domId).removeClass("doingAnimate");
      queue.push(itemId);
    },
    fail: function(){
      preselectedQueue.push(itemId)
    }
  })
};

//生成循环动画
var generateLoopBlock = function(){
  if(!queue.length) return;
  if(!GLOBAL) return;
  var index = utils.random(queue.length);
  var id = "item_" + queue.splice(index, 1);
  var li = document.getElementById(id);
  li.style.left = utils.random(bodyWidth-picWidth/2) + "px";
  animation(id);
  setTimeout(generateLoopBlock, winnerDisplayTimeInterval)
};

init(generateLoopBlock);

var getResultTemplate = function(count){
  if(count == 20){
    return result20Template
  }else if(count == 40){
    return result40Template
  }else if(count == 1){
    return resultTVTemplate
  }else{
    return resultOtherTemplate
  }
};

var showWinner = function(queue, next){
  var id = "";
  var index = 0;
  async.whilst(function(){
    id = queue.shift();
    index = index + 1;
    return id
  }, function(callback){
    $("#item_" + id).css("z-index", index)
      .animate(
        {
          width: "300px",
          height: "450px",
          left: (bodyWidth/2 - 50) + "px",
          top: (100-bodyHeight) +"px"
        },{
          duration: 1500,
          complete: function () {
            var self = this;
            setTimeout(function(){
              $(self).fadeOut(function(){
               $(this).remove()
              })
            }, 1000);
          }
        });
   setTimeout(callback, 800);
  }, next)

};

var showWinnerList = function(queue, next){
  var ready = [];
  if(queue.length == 1){
    showWinner(queue, next);
    return;
  }
  var startLeft = bodyWidth * 0.05;
  var startTop = bodyHeight * 0.1;
  var width = bodyWidth * 0.1 - 20;
  var height = bodyHeight * 0.2;
  for(var index = 0,length = queue.length; index < length; index++){
    var left = 20 + startLeft + (index % 10) * width;
    var top = startTop + parseInt(index / 10) * height + 15;
    var id = "#item_" + queue[index];
    $(id)
      .css("z-index", parseInt(index / 10) + 2)
      .animate(
          {
            width: width + "px",
            height: height + "px",
            left: left + "px",
            top: (top - bodyHeight) + "px"
          },{
          duration: 1500,
          complete: function () {
            ready.push(id);
          }
      });
  }
  var timer =  setInterval(function(){
    if(ready.length == queue.length){
      next();
      clearInterval(timer)
    }
  }, 50)

};

//从停顿处选择获取的人
var chooseTheWinner = function(){
  var queue = utils.chooseRandomArray(preselectedQueue, winnerCount);
  $("#mask").show();
  showWinnerList([].concat(queue), function(){
    service.postEmployeeList(queue, function(data){

      var template = getResultTemplate(winnerCount);
      var productList = data.productList || [];
      var html = template(
        {
          list: data.employeeList,
          pro1: productList[0],
          pro2: productList[1],
          pro3: productList[2],
          pro4: productList[3]
        });
      $("#modal-window").html(html);
      $("#modal-window div").fadeIn(function(){
        $("#vessel").fadeOut();
      });

    });
  });
};

if(!store.get('hadDoWinnerCount')){
  store.set('hadDoWinnerCount', 0);
}


//操作失误
var operationalError = false;
//操作间隔
var operationalInterval = 3000;
$(document).bind('keyup.return', function(){
  if(operationalError){
    return;
  }
  operationalError = true;
  setTimeout(function(){operationalError = false}, operationalInterval);
  if(GLOBAL){
    $(".doingAnimate").stop();
    bgMusic.pause();
    stopMusic.play();
    GLOBAL = false;
    setTimeout(function(){
      chooseTheWinner();
    }, 500)
  }else{
    bgMusic.play();
    init(generateLoopBlock);
  }
});