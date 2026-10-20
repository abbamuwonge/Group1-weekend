
// Run me with:  dart run classes.dart

class Person {
  String name; // Stores the person's name
  int age; // Stores the person's age

  Person(this.name, this.age); // we Set the name and age when creating a person

  void introduce() { // this function that introduces the person
    print("Hi, my name is $name and I am $age years old.");
  }
}

// inheritance: Student gets name and age from Person
class Student extends Person {
  String school; // Stores the name of the school

  //here we sets the student's details and sends name and age to Person
  Student(String name, int age, this.school) : super(name, age);

  @override // Uses a different introduction for a student
  void introduce() {
    print("Hi, my name is $name, I am $age years old and I study at $school.");
  }
}

// Teacher also gets name and age from Person
class Teacher extends Person {
  String subject; // Stores the subject the teacher teaches

  // Sets the teacher's details and sends name and age to Person
  Teacher(String name, int age, this.subject) : super(name, age);

  @override // Uses a different introduction for a teacher
  void introduce() {
    print("Hi, my name is $name, I am $age years old and I teach $subject.");
  }
}

void main() {
  var person = Person('Kamara', 30); // Creates a person named Kamara
  person.introduce(); // Displays Kamara's details

  var student = Student('Aslam', 20, 'Makerere University'); // Creates a student
  student.introduce(); // Displays the student's details

  var teacher = Teacher('Abbasi', 25, 'Computer Science'); // Creates a teacher
  teacher.introduce(); // Displays the teacher's details
}


// ADDITIONAL NOTES
// Class: A plan used to create objects. Person is a class.
// Object: Something created from a class. person is an object created from Person.
// String: Stores text, such as a name or subject.
// int: Stores whole numbers, such as age.
// Constructor: Sets the information needed when creating an object. For example, Person(this.name, this.age).
// extends: Allows one class to get information and functions from another class.
// super(name, age): Sends the name and age to the parent class, Person.
// @override: Allows a child class to provide its own version of a function.
// void: Means the function does not return a value.