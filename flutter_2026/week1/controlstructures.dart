// Run me with:  dart run controlstructures.dart

void main() {
  int score = 75;

  if (score >= 90) {   
    print('A');   //this will print 'A' if the score is greater than or equal to 90
  } else if (score >= 70) {
    print('B');   // this will print 'B' if the score is greater than or equal to 70 but less than 90
  } else {
    print('C');   // this will print 'C' if the score is less than 70
  }

  for (int i = 0; i < 4; i++) {
    print('Count: $i'); //this will print 'Count: 0', 'Count: 1',  'Count: 2' and 'Count: 3' and on separate lines
  }

  int n = 5;
  while (n > 0) {
    print('subtract: $n');    
    n--;   //this will print 'subtract: 5', 'subtract: 4', 'subtract: 3', 'subtract: 2', and 'subtract: 1' on separate lines
  }
}


// Run me with:  dart run controlstructures.dart


