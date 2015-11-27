function Student(fname, lname) {
  this.fname = fname;
  this.lname = lname;
  this.courses = []
}

Student.prototype.name = function() {
  return this.fname + " " + this.lname;
}
Student.prototype.courses = function() {
  return this.courses;
}

Student.prototype.enroll = function(course) {
  this.courses.push(course);
  course.students.push(this);
}

function Course(name, department, credits) {
  this.name = name;
  this.department = department;
  this.credits = credits;
  this.students = []
}

Course.prototype.students = function() {
  return this.students;
}

Course.prototype.add_student = function(student) {
  student.enroll(this);
}

var stu1 = new Student("Ryan", "Samp");
var stu2 = new Student("Huan", "Ji");
var cour = new Course("a/A", "comp sci", 0)

stu1.enroll(cour)
stu2.enroll(cour)

console.log(cour.students)
console.log(stu1.courses)
