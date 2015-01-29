utils = {
  randomSection: function(min, max){
    return parseInt(Math.random() * max + 1) + min
  },
  random: function(max){
    max = max.length || max;
    return parseInt(Math.random() * max)
  },
  chooseRandomArray: function(list, num){
    if(list.length < num) return list;
    var queue = []; //中奖的
    for(var i = 0; i < num; i++){
      var index = utils.random(list);
      queue.push(list.splice(index, 1)[0]);
    }
    return queue;
  },
  generateBlockItem: function(item){
    var li = document.createElement('li');
    var size = ["", "small"];
    li.className = "ball_" + utils.randomSection(0, 6) + " "+size[utils.random(2)];
    li.innerHTML =
      "<img src='/api/avatar/@img'>".replace("@img", item.avatar);
    li.id = "item_" + item.id;
    return li
  },
  generateDecorate: function(id){
    var li = document.createElement('li');
    var randomSize = utils.random(2);
    var randomNum = utils.randomSection(0, 6);
    li.innerHTML =
      "<img src='/image/ball_@num@img.png' style='width:@width'>"
        .replace("@img", ["", "_small"][randomSize])
        .replace("@num", randomNum)
        .replace("@width", ["120px", "90px"][randomSize]);
    li.id = "decorate_ball_" + id;
    return li
  }
};