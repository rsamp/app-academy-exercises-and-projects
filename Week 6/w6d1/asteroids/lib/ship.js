(function() {
  if (typeof window.Asteroids === "undefined") {
    window.Asteroids = {};
  }
  var Asteroids = window.Asteroids;
  var Util = Asteroids.Util;
  var MovingObject = Asteroids.MovingObject;

  var Ship = Asteroids.Ship = function(game){
    this.RADIUS = 5;
    this.COLOR = "#000000";
    this.vel = 0;
    this.pos = game.randomPosition;
    this.game = game;
  };


  Util.inherits(Ship, MovingObject);
});
