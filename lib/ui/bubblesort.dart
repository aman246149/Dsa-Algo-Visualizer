import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:visualizer/provider/bubble_sort_provider.dart";
import 'package:flutter_animate/flutter_animate.dart';
import "boxes.dart";

class BubbleSort extends StatefulWidget {
  const BubbleSort({super.key});

  @override
  State<BubbleSort> createState() => _BubbleSortState();
}

class _BubbleSortState extends State<BubbleSort> {
  bool isCompleted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          isCompleted = await context.read<BubbleSortProvider>().bubbleSort();
          setState(() {});
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Spacer(),
            Expanded(
              child: ListView.separated(
                itemCount: context.read<BubbleSortProvider>().arr.length,
                separatorBuilder: (context, index) => const SizedBox(
                  width: 0,
                ),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  //setting currently redender index
                  if (context.read<BubbleSortProvider>().currentlySortedIndex !=
                      null) {
                    context.read<BubbleSortProvider>().showColorIndex(index);
                  }

                  return CustomBox(
                    height: 500,
                    width: 25,
                    color: isCompleted
                        ? Colors.green
                        : context
                                .watch<BubbleSortProvider>()
                                .alreadySortedIndexes
                                .contains(index)
                            ? Colors.green
                            : context.watch<BubbleSortProvider>().color,
                    text: context
                        .watch<BubbleSortProvider>()
                        .arr[index]
                        .toString(),
                  ).animate(
                      effects: [ShakeEffect(), FadeEffect(), ShimmerEffect()]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
