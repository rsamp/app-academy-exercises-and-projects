/* eslint no-extend-native: 0, semi: 2 */

function range(start, end){
  if(end < start){
    return [];
  } else {
    var arr = range(start, end-1);
    arr.push(end);
    return arr;
  }
}

// console.log(range(3, 11));

function sum(array){
  if(array.length === 1){
    return array[0];
  } else {
    return array.pop() + sum(array);
  }
}

console.log(sum([1,4,8]));

// function fibonacci()
