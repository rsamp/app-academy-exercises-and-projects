Function.prototype.inherits = function(SuperClass){
  function Surrogate(){}
  Surrogate.prototype = SuperClass.prototype;
  this.prototype = new Surrogate();
  this.prototype.constructor = this;
};



function MovingObject () {}

function Ship () {}
Ship.inherits(MovingObject);

function Asteroid () {}
Asteroid.inherits(MovingObject);

MovingObject.prototype.fly = function(){
  console.log("vrooooom");
};

Asteroid.prototype.crumble = function () {
  console.log("crumbling");
};

var object = new MovingObject();
var ship = new Ship();
var asteroid = new Asteroid();

object.fly();
ship.fly();
asteroid.fly();

// object.crumble();
// ship.crumble();
asteroid.crumble();

console.log(Asteroid.prototype);
