// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

enum Speed { fast, slow, verySlow, ultraSlow }

class SortProvider extends ChangeNotifier {
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
  Duration duration = const Duration(milliseconds: 10);
  bool isSortingCompleted = false;
  Speed speed = Speed.fast;

  Future<void> bubbleSort() async {
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
            duration,
            () {
              notifyListeners();
            },
          );
        }
      }
// this is outside of j loop and wait till element sorted
      await Future.delayed(
        duration,
        () {
          alreadySortedIndexes.add(size - i - 1);
          notifyListeners();
        },
      );
    }

    isSortingCompleted = true;
  }

  Future<void> selectionSort() async {
    for (int i = 0; i < arr.length - 1; i++) {
      int minimumIndex =
          i; // Store the index of the minimum element, not the value itself

      for (int j = i + 1; j < arr.length; j++) {
        if (arr[j] < arr[minimumIndex]) {
          currentlySortedIndex =
              Indexes(firstIndex: j, secondIndex: minimumIndex);
          minimumIndex = j; // Update the index of the minimum element
//this is for waiting i and j color
          await Future.delayed(
            duration,
            () {
              notifyListeners();
            },
          );
        }
      }

      // Swap the elements
      int temp = arr[i];
      arr[i] = arr[minimumIndex];
      arr[minimumIndex] = temp;

      // this is outside of j loop and wait till element sorted
      await Future.delayed(
        duration,
        () {
          alreadySortedIndexes.add(i);
          notifyListeners();
        },
      );
    }

    // print(arr.toString());
    isSortingCompleted = true;
  }

  Future<void> insertionSort() async {
    int size = arr.length;

    for (int step = 1; step < size; step++) {
      int key = arr[step];
      int j = step - 1;

      // Compare key with each element on the left of it until an element smaller than
      // it is found.
      // For descending order, change key<arr[j] to key>arr[j].
      while (j >= 0 && key < arr[j]) {
        //this is for waiting i and j color
        currentlySortedIndex = Indexes(firstIndex: step, secondIndex: j);
        await Future.delayed(
          duration,
          () {
            notifyListeners();
          },
        );

        arr[j + 1] = arr[j];
        --j;
      }

      // Place key at after the element just smaller than it.
      arr[j + 1] = key;
    }
    notifyListeners();
    isSortingCompleted = true;
  }

  void reset() {
    arr = [
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

    currentlySortedIndex = null;
    isSortingDone = false;

    color = Colors.red;
    alreadySortedIndexes = [];
    isSortingCompleted = false;
    notifyListeners();
  }

  void showColorIndex(int currentlyRenderIndex) {
    color = Colors.red;
    Indexes? indexes = currentlySortedIndex;
    if (indexes != null) {
      if (currentlyRenderIndex == indexes.firstIndex ||
          currentlyRenderIndex == indexes.secondIndex) {
        color = Colors.deepPurple;
      }
    }
  }

  void changeDuration(Speed selectedSpeed) {
    speed = selectedSpeed;
    switch (selectedSpeed) {
      case Speed.fast:
        duration = const Duration(milliseconds: 10); // Set duration for Speed x1
        break;
      case Speed.slow:
        duration = const Duration(milliseconds: 100); // Set duration for Speed x2
        break;
      case Speed.verySlow:
        duration = const Duration(milliseconds: 500); // Set duration for Speed x2
        break;
      case Speed.ultraSlow:
        duration = const Duration(milliseconds: 1000); // Set duration for Speed x2
        break;
    }
    notifyListeners();
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
