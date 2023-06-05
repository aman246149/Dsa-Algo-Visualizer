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
  List<Widget> pages = [const BubbleSort(), const SelectionSort(), const InsertionSort()];

  PageController controller = PageController();
  void reset(Function() callAlgorithm) {
    // if (!context.read<SortProvider>().isSortingCompleted) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Wait For Algorithm To Finish Please'),
    //       duration: Duration(seconds: 2),
    //     ),
    //   );
    //   return;
    // }
    context.read<SortProvider>().reset();
    callAlgorithm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alogo Visulizer"),
        actions: [
          const CommonRow(
            color: Colors.red,
            text: "UnSorted",
          ),
          const CommonRow(
            color: Colors.green,
            text: "Sorted",
          ),
          const CommonRow(
            color: Colors.purple,
            text: "Comparision",
          ),
          ElevatedButton(
            onPressed: () {
              Speed speed = context.read<SortProvider>().speed;
              if (speed == Speed.fast) {
                context.read<SortProvider>().changeDuration(Speed.slow);
              } else if (speed == Speed.slow) {
                context.read<SortProvider>().changeDuration(Speed.verySlow);
              } else if (speed == Speed.verySlow) {
                context.read<SortProvider>().changeDuration(Speed.ultraSlow);
              } else {
                context.read<SortProvider>().changeDuration(Speed.fast);
              }
            },
            child: Text(context.watch<SortProvider>().speed.name),
          ),
          const SizedBox(
            width: 20,
          ),
          ElevatedButton(
              onPressed: () {
                context.read<SortProvider>().reset();
              },
              child: const Text("Reset")),
          const SizedBox(
            width: 30,
          )
        ],
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              height: double.maxFinite,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                separatorBuilder: (context, index) => const SizedBox(
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
                physics: const NeverScrollableScrollPhysics(),
                controller: controller,
                children: pages,
              )),
        ],
      ),
    );
  }
}

class CommonRow extends StatelessWidget {
  const CommonRow({
    super.key,
    required this.color,
    required this.text,
  });
  final Color color;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 8,
          backgroundColor: color,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 12,
        ),
      ],
    );
  }
}
