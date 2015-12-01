Function.prototype.myBind = function (obj) {
  //var obj = arguments[0];
  var boundArgs = [].slice.call(arguments, 1);
  console.log(arguments);

  var fn = this;
  return (function () {
    console.log(arguments);
    var passedArgs = [].slice.call(arguments);

    return fn.apply(obj, boundArgs.concat(passedArgs));
  });
};

// function Cat(name) {
//   this.name = name;
// }
//
// Cat.prototype.says = function (sound) {
//   console.log(this.name + " says " + sound + "!");
// };
//
// var markov = new Cat("Markov");
// var breakfast = new Cat("Breakfast");
//
// // markov.says("meow");
// // Markov says meow!
//
// markov.says.myBind(breakfast, "meow")();
// // Breakfast says meow!
//
// markov.says.myBind(breakfast)("meow");
//
// // Breakfast says meow!
//
// var notMarkovSays = markov.says.myBind(breakfast);
// notMarkovSays("meow");
// // Breakfast says meow!

var boundLog = console.log.myBind(console, 1, 2, 3);
boundLog(4, 5, 6);
boundLog('A', 'B');
