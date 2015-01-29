var bgMusic =  new Howl({
  urls: ['audio/bg.mp3'],
  volume: 1,
  loop: true
}).play();

var stopMusic = new Howl({
  urls: ['audio/stop.mp3'],
  volume: 1
});