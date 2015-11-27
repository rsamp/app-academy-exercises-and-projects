/* eslint no-extend-native: 0, semi: 2 */

var func2 = function(x){
  return x + 3;
};

Array.prototype.myEach = function(func) {
  for(var i = 0; i < this.length; i++){
    func(this[i]);
  }
};

Array.prototype.myMap = function(func) {
  var mappedArray = [];
  this.myEach(function(element) {
    mappedArray.push(func(element));
  });
  return mappedArray;
};

// var a = [1, 2, 3];
// console.log(a.myMap(func2));

Array.prototype.myInject = function(func) {
  var accumulator = null;
  this.myEach(function(element) {
    if(accumulator === null){
      accumulator = element;
    } else {
      accumulator = func(accumulator, element);
    }
  });
  return accumulator;
};

var accumFunc = function(acc, el){
  return acc + el;
};

// var a = [1, 2, 3];
// console.log(a.myInject(accumFunc));
