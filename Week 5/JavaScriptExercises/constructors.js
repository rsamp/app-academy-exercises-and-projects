function Cat(name, owner){
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function(){
  return "Everyone loves " + this.name + "!";
}

Cat.prototype.meow = function() {
  return this.name.repeat(3)
}

var cat1 = new Cat("Gizmo", "Ned")
var cat = new Cat("Breakfast", "Ned")

console.log(cat.meow())
cat.meow = function() {
  return this.name;
}
console.log(cat.meow())

console.log(cat.cuteStatement())
console.log(cat1.meow())
