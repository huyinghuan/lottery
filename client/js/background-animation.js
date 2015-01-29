(function(){

var bodyWidth = 1440;
var bodyHeight = 900;
var picHeight = 135;
var backgroundDisplayTimeInterval = 200; //背景气球飘出来的时间间隔　单位毫秒
var queue = [];

for(var index = 0; index < 50; index++){
  queue.push(index);
}


//生成动画背景
var generateAnimationBackGroup = function(){
  for(var i = 0; i < 50; i++){
    $("#decorate").append(utils.generateDecorate(i))
  }
};

var animationBackGroup = function(id) {
  var domId = "#" + id;
  var dataId = id.replace("decorate_ball_", "");
  $(domId).animate({top: "-="+(bodyHeight+picHeight)+"px"}, {
    duration: 5000,
    complete: function () {
      $(domId).css("top",bodyHeight+"px");
      queue.push(dataId);
    }
  })
};

//动画循环
var generateAnimationBackGroupLoop = function(){
  var index = utils.random(queue.length);
  var id = "decorate_ball_" + queue.splice(index, 1);
  var li = document.getElementById(id);
  li.style.left = utils.random(bodyWidth) + "px";
  animationBackGroup(id);
  setTimeout(generateAnimationBackGroupLoop, backgroundDisplayTimeInterval)
};

//背景动画
generateAnimationBackGroup();
generateAnimationBackGroupLoop();

})();