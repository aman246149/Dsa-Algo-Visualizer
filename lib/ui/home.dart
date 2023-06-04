import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visualizer/provider/sort_provider.dart';
import 'package:visualizer/ui/bubblesort.dart';
import 'package:visualizer/ui/selectionsort.dart';

import 'insertion_sort.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> algorithms = ["BubbleSort", "SelectionSort", "InserstionSort"];
  List<Widget> pages = [BubbleSort(), SelectionSort(), InsertionSort()];
  bool firstTimeAlgoRun = true;
  PageController controller = PageController();
  void reset(Function() callAlgorithm) {
    if (firstTimeAlgoRun) {
      callAlgorithm();
      firstTimeAlgoRun = false;
      return;
    }

    if (!context.read<SortProvider>().isSortingCompleted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Wait For Algorithm To Finish Please'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    context.read<SortProvider>().reset();
    callAlgorithm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: double.maxFinite,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                separatorBuilder: (context, index) => SizedBox(
                  height: 15,
                ),
                itemBuilder: (context, index) => ElevatedButton(
                    onPressed: () {
                      controller.jumpToPage(0);
                      if (index == 0) {
                        reset(
                          () {
                            context.read<SortProvider>().bubbleSort();
                          },
                        );
                      } else if (index == 1) {
                        reset(
                          () {
                            context.read<SortProvider>().selectionSort();
                          },
                        );
                      } else if (index == 2) {
                        reset(
                          () {
                            context.read<SortProvider>().insertionSort();
                          },
                        );
                      }
                    },
                    child: Text(algorithms[index])),
                itemCount: algorithms.length,
              ),
            ),
          ),
          Expanded(
              flex: 6,
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                children: pages,
                controller: controller,
              )),
        ],
      ),
    );
  }
}
