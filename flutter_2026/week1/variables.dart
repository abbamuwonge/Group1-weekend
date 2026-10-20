// Run me with:  dart run variables.dart

void variables() {
  // type inference, like var in Java or just assignment in Python
  var name = 'Alice'; //var tells Dart to work out the type of the variable. Since 'Alice' is text, Dart knows that name is a String.
  String city = 'Kampala'; //String city means you are telling Dart directly that city will hold text.
                           //name stores Alice, and city stores Kampala.


  final int age = 25; //final means you can give the variable a value only once
 //age = 26; // ERROR: can't reassign a final variable
 //this error happens because we already declared it as final, so it means we gave
 //it a value once and cant change it later


  
  const double pi = 3.14159; //const is used for a value that must be fixed when the program is compiled. 
  //Here, pi is set to 3.14159 and cannot be changed.
  // pi = 3.0; // ERROR: can't reassign a const either
  

  print('$name lives in $city, age $age'); // string interpolation with $
  print('Next year: ${age + 1}'); // ${} for expressions
  print('Area of a circle with radius 2: ${pi * 2 * 2}'); // this calculates the area of a circle with radius 2 using the formula pi * r^2, where r is the radius then it displays itin the terminal. 
}

//print() displays something in the terminal.
//The $ sign lets you put a variable inside a string. When you need to calculate something inside the 
//string, use ${}.

//*************OUTPUT WILL BE*****************
//Alice lives in Kampala, age 25
//Next year: 26*


// Every Dart program starts running from main()
void main() {
  variables();
}
