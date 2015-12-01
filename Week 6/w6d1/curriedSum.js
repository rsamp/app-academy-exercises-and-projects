function curriedSum(numArgs) {
  var numbers = [];

  return function _curriedSum(addend) {
    numbers.push(addend);
    if (numbers.length === numArgs) {
      var thisSum = 0;
      numbers.forEach(function(num) {
        thisSum += num;
      });
      return thisSum;
    } else {
      return _curriedSum;
    }
  };
}

var sum = curriedSum(4);
console.log(sum(5)(30)(20)(1));
