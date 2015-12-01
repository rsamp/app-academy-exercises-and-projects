(function() {
  if (typeof window.Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Util = window.Asteroids.Util = {};

  Util.inherits = function(ChildClass, ParentClass) {
    function Surrogate(){}
    Surrogate.prototype = ParentClass.prototype;
    ChildClass.prototype = new Surrogate();
    ChildClass.prototype.constructor = ChildClass;
  };

  Util.randomVec = function(length) {
    var vector = [];
    vector[0] = (length / Math.sqrt(2)) * Math.random();
    vector[1] = (length / Math.sqrt(2)) * Math.random();
    return vector;
  };

})();
