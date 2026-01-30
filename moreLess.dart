void main() {
  int a = 22;
  int b = 5;
  int c = 11;

  print('Numbers: $a, $b, $c');

  //Bigger One
  int more = a; //Think of a as the Bigger One

  if (b > more) {
    more = b; // if 'b' wins, b its the new Champion
  } else if (c > more) {
    more = c; // if 'c' wins, c is the New Champion
  }

  // Small One
  int less = a; //all is the same as the other one just for a small one, duh =/

  if (b < less) {
    less = b;
  } else if (c < less) {
    less = c;
  }

  //Middle
  int middle = a;

  if (b > less && b < more) {
    middle = b;
  } else if (c > less && c < more) {
    middle = c;
  }

  if (more != less || less != middle ) { 
    // Result
    print('The Biggest Number is: $more');
    print('The Smallest Number is: $less');
    print("The One that's left is:  $middle The middle one, duh =/ (I wanna go to sleep, I'm tired #HELP) ",);
  }else{
    print('All are Equal, u Dumb?');
  }
}
