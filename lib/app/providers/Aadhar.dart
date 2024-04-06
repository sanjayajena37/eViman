class Aadhar{
  static List<List<int>> d = [
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 0, 6, 7, 8, 9, 5],
    [2, 3, 4, 0, 1, 7, 8, 9, 5, 6],
    [3, 4, 0, 1, 2, 8, 9, 5, 6, 7],
    [4, 0, 1, 2, 3, 9, 5, 6, 7, 8],
    [5, 9, 8, 7, 6, 0, 4, 3, 2, 1],
    [6, 5, 9, 8, 7, 1, 0, 4, 3, 2],
    [7, 6, 5, 9, 8, 2, 1, 0, 4, 3],
    [8, 7, 6, 5, 9, 3, 2, 1, 0, 4],
    [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
  ];
  static List<List<int>> p = [
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 5, 7, 6, 2, 8, 3, 0, 9, 4],
    [5, 8, 0, 3, 7, 9, 6, 1, 4, 2],
    [8, 9, 1, 6, 0, 4, 3, 5, 2, 7],
    [9, 4, 5, 3, 1, 2, 6, 8, 7, 0],
    [4, 2, 8, 6, 5, 7, 3, 9, 0, 1],
    [2, 7, 9, 3, 8, 0, 6, 4, 1, 5],
    [7, 0, 4, 6, 9, 1, 3, 2, 5, 8]
  ];
  static List<int> inv = [0, 4, 3, 2, 1, 5, 6, 7, 8, 9];

  static String generateVerhoeff(String num) {
    int c = 0;
    List<int> myArray = stringToReversedIntArray(num);
    for (int i = 0; i < myArray.length; i++) {
      c = d[c][p[(i + 1) % 8][myArray[i]]];
    }
    return inv[c].toString();
  }

  static bool validateVerhoeff(String num) {
    int c = 0;
    List<int> myArray = stringToReversedIntArray(num);
    for (int i = 0; i < myArray.length; i++) {
      c = d[c][p[i % 8][myArray[i]]];
    }

    print("aadhar valide>>" + (c == 0).toString());
    return c == 0;
  }

  static List<int> stringToReversedIntArray(String num) {
    List<int> myArray = List<int>.filled(num.length, 0);
    for (int i = 0; i < num.length; i++) {
      print(int.parse(num.substring(i, i + 1)));
      myArray[i] = int.parse(num.substring(i, i + 1));
    }
    myArray = reverse(myArray);
    return myArray;
  }

  static List<int> reverse(List<int> myArray) {
    List<int> reversed = List<int>.filled(myArray.length, 0);
    for (int i = 0; i < myArray.length; i++) {
      reversed[i] = myArray[myArray.length - (i + 1)];
    }
    return reversed;
  }
}