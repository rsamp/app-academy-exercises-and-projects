(function() {
  if (typeof window.Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Asteroids = window.Asteroids;
  var Util = Asteroids.Util;
  var MovingObject = Asteroids.MovingObject;

  var Asteroid = Asteroids.Asteroid = function(pos, game) {
    this.COLOR = "#ff0000";
    this.RADIUS = 25;
    var vector = Util.randomVec(1); //revisit 'length'
    this.game = game;

    return new MovingObject(pos, vector, this.RADIUS, this.COLOR, game);
  };

  Util.inherits(Asteroid, MovingObject);

})();
