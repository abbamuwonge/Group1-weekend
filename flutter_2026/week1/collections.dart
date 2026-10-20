// Run me with:  dart run collections.dart

void collections() {
  List<String> fruits = ['Apple', 'Banana', 'Orange'];
  fruits.add('Mango'); // Adding an element to the list
  print(fruits); // Output: [Apple, Banana, Orange, Mango]

  for (var fruit in fruits) {
    print(fruit); // Output: Apple, Banana, Orange, Mango (one per line)
  }

  Map<String, int> ages = {
    'Alice': 25,
    'Bob': 30,
    'Charlie': 35,
    'Abbasi': 28, // here we Added another person to the map
  };

  print(ages['Alice']); // Output age is  25
  print(ages['Bob']); // Output age is  30
  print(ages['Charlie']); // Output age is  35
  print(ages['Abbasi']); // Output age is  28`

  // Print each person's name and age
  for (var entry in ages.entries) {
    print('${entry.key}: ${entry.value}');
  }
}

void main() {
  collections();
}
