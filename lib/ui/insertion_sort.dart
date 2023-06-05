import "package:flutter/material.dart";
import "package:provider/provider.dart";
import 'package:visualizer/provider/sort_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import "boxes.dart";

class InsertionSort extends StatefulWidget {
  const InsertionSort({super.key});

  @override
  State<InsertionSort> createState() => _InsertionSortState();
}

class _InsertionSortState extends State<InsertionSort> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Spacer(),
            Expanded(
              child: ListView.separated(
                itemCount: context.read<SortProvider>().arr.length,
                separatorBuilder: (context, index) => const SizedBox(
                  width: 0,
                ),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  //setting currently redender index
                  if (context.read<SortProvider>().currentlySortedIndex !=
                      null) {
                    context.read<SortProvider>().showColorIndex(index);
                  }

                  return CustomBox(
                    height: 500,
                    width: 25,
                    color: context.watch<SortProvider>().isSortingCompleted
                        ? Colors.green
                        : context
                                .watch<SortProvider>()
                                .alreadySortedIndexes
                                .contains(index)
                            ? Colors.green
                            : context.watch<SortProvider>().color,
                    text: context.watch<SortProvider>().arr[index].toString(),
                  ).animate(
                      effects: [const ShakeEffect(), const FadeEffect(), const ShimmerEffect()]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
