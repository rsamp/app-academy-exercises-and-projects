/* eslint no-extend-native: 0, semi: 2 */

Array.prototype.my_uniq = function() {
  var arr = [];
  for ( var i = 0; i < this.length ; i++ ) {
    if ( arr.indexOf(this[i]) === -1 ) {
      arr.push(this[i]);
    }
  }
  return arr;
};

Array.prototype.two_sum = function() {
  var sumArray = [];
  var that = this;
  this.forEach(function(element, i) {
    that.forEach(function(element2, i2) {
      if (i2 > i && (element + element2) === 0) {
        sumArray.push([i, i2]);
      }
    });
  });
  return sumArray;
};

// console.log([-1, 0, 2, -2, 1].two_sum())

Array.prototype.myTranspose = function() {
  var transposedArray = [];
  for(var n = 0; n < this[0].length; n++) {
    transposedArray.push([]);
  }
  this.forEach(function(row, i){
    row.forEach(function(el, j){
      transposedArray[j].push(el);
    });
  });
  return transposedArray;
};

// console.log([
//     [0, 1, 2],
//     [3, 4, 5],
//     [6, 7, 8]
//   ].myTranspose());
// var newArray = []
