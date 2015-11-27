/* eslint no-extend-native: 0, semi: 2 */

Array.prototype.bubbleSort = function(func) {
  var sorted = false;
  while(!sorted){
    sorted = true;
    for(var i = 0; i < this.length - 1; i++){
      if(this[i] > this[i+1]){
        var temp = this[i];
        this[i] = this[i+1];
        this[i+1] = temp;
        sorted = false;
      }
    }
  }
  return this;
};

// console.log([5,2,7,5,8,4,3,9,4,1,7,6,3].bubbleSort());

String.prototype.subStrings = function(func) {
  var subStringArray = [];
  for (var i = 0; i < this.length; i++ ) {
    for (var j = i; j < this.length; j++ ) {
      subStringArray.push(this.substring(i, j + 1));
    }
  }
  return subStringArray;
};

// console.log("cat".subStrings());
