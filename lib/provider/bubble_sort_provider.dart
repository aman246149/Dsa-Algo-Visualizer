// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BubbleSortProvider extends ChangeNotifier {
  List<int> arr = [
    43,
    12,
    87,
    65,
    23,
    9,
    34,
    76,
    19,
    5,
    82,
    37,
    64,
    54,
    29,
    14,
    77,
    93,
    8,
    41,
    62,
    16,
    89,
    31,
    58,
    72,
    27,
    39,
    75,
    21,
    49,
    68,
    2,
    51,
    83,
    10,
    46,
  ];
  Indexes? currentlySortedIndex;
  bool isSortingDone = false;

  Color color = Colors.red;
  List<int> alreadySortedIndexes = [];

  Future<bool> bubbleSort() async {
    int size = arr.length;

    // loop to access each arr element
    for (int i = 0; i < size - 1; i++) {
      // loop to compare arr elements
      for (int j = 0; j < size - i - 1; j++) {
        // compare two adjacent elements
        // change > to < to sort in descending order
        if (arr[j] > arr[j + 1]) {
          // swapping occurs if elements
          // are not in the intended order
          int temp = arr[j];
          arr[j] = arr[j + 1];
          arr[j + 1] = temp;
          currentlySortedIndex = Indexes(firstIndex: j, secondIndex: j + 1);

//this is for waiting i and j color
          await Future.delayed(
            const Duration(milliseconds: 50),
            () {
              notifyListeners();
            },
          );
        }
      }
// this is outside of j loop and wait till element sorted
      await Future.delayed(
        const Duration(milliseconds: 50),
        () {
          alreadySortedIndexes.add(size - i - 1);
          notifyListeners();
        },
      );
    }

    return true;
  }

  void showColorIndex(int currentlyRenderIndex) {
    color = Colors.red;
    Indexes? indexes = currentlySortedIndex;
    if (indexes != null) {
      if (currentlyRenderIndex == indexes.firstIndex ||
          currentlyRenderIndex == indexes.secondIndex) {
        color = Colors.green;
      }
    }
  }
}

class Indexes {
  int firstIndex;
  int secondIndex;
  Indexes({
    required this.firstIndex,
    required this.secondIndex,
  });
}
