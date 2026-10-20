
// Run me with:  dart run functions.dart

// Basic function — looks just like Java minus the access modifier requirement
int add(int a, int b) {
  return a + b;
}

// Arrow syntax for one-line functions (like a lambda, but for named functions too)
int square(int x) => x * x; // same as { return x * x; } but shorter

// Exercise 3: Check if a number is even or odd
bool isEven(int n) => n % 2 == 0;

// Optional named parameters — this one is very Flutter-specific and important
void greet({required String name, String greeting = 'Hello'}) {
  print('$greeting, $name!');
}

void main() {
  print(add(2, 3)); // prints 5
  print(square(5)); // prints 25

  // we Checked whether the numbers are even
  print(isEven(4)); // it will print true if the number is even
  print(isEven(7)); // it will print false if the number is odd

  greet(name: 'Beatrice');                    // uses default greeting
  greet(name: 'Sam', greeting: 'Hey there');   // overrides it
}



//ADDITIONAL NOTES:
//bool means the function returns either true or false.
//% gives the remainder after division. For example, 4 % 2 gives 0, while 7 % 2 gives 1.
//n % 2 == 0 checks whether the number divides by 2 with no remainder.
//=> lets us write this short function on one line.