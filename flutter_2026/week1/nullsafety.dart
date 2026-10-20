
// Run me with:  dart run nullsafety.dart

// This function looks for a nickname.
// It returns null if the name has no nickname.
String? findNickname(String name) {
  if (name == 'Alice') return 'Al';
  return null; // No nickname was found
}

void nullsafety() {
  String? nickname = findNickname('Bob'); // Bob has no nickname
  // String nickname2 = null; // This gives an error because String cannot be null

  // Check the nickname length only if it is not null
  print(nickname?.length); // Prints null because Bob has no nickname

  // Use Anonymous if no nickname is found
  String displayName = nickname ?? 'Anonymous';
  print(displayName); // Prints Anonymous

  nickname = findNickname('Alice');

  // Check if the nickname exists before using it
  if (nickname != null) {
    print(nickname.length); // Prints 2
  }

  //Tried finding a nickname using my name
  String? myNickname = findNickname('Abbasi');

  // Print a message if no nickname is found
  print(myNickname ?? 'No nickname found'); //its will print this because my name has no nickname
}

void main() {
  nullsafety();
}


//null means there is no value.
//String? means the variable can store text or null.
//?. checks that a value is not null before using it.
//?? gives another value when the first value is null.
//if (nickname != null) checks that a nickname exists before printing its length.