(function() {
  if (typeof window.Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Asteroids = window.Asteroids;

  var GameView = Asteroids.GameView = function(Game, ctx) {
    this.Game = Game;
    // this.game = new Asteroids.Game();

    this.ctx = ctx;
  };

  GameView.prototype.start = function () {
    var that = this;
    // this.Game.draw(this.ctx);
    return window.setInterval(function() {
      that.Game.draw(that.ctx);
      that.Game.step();
    }, 20);
  };

})();
