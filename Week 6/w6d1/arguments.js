function sum() {
  var runningSum = 0;
  for (var i=0; i < arguments.length; i++) {
    runningSum += arguments[i];
  }
  return runningSum;
}


function sum2() {
  var runningSum = 0;
  var args = [].slice.call(arguments);
  args.forEach(function(arg) {
    runningSum += arg;
  });
  return runningSum;
}
console.log(sum2(1, 2, 3, 4, 5));
