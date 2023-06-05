
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import 'package:visualizer/provider/sort_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import "boxes.dart";

class BubbleSort extends StatefulWidget {
  const BubbleSort({super.key});

  @override
  State<BubbleSort> createState() => _BubbleSortState();
}

class _BubbleSortState extends State<BubbleSort> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
          itemCount: context.read<SortProvider>().arr.length,
          separatorBuilder: (context, index) => const SizedBox(
            width: 0,
          ),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            //setting currently redender index
            if (context.read<SortProvider>().currentlySortedIndex != null) {
              context.read<SortProvider>().showColorIndex(index);
            }
            // double maxHeight = MediaQuery.of(context).size.height - 100;
            // double minHeight = 120;
            int element = context.read<SortProvider>().arr[index];
            int len = element.toString().length;
            double dynamicHeight = 0;
            if (len == 1) {
              dynamicHeight = element.toDouble() * 10;
              if (element <= 9 && element >= 3) {
                dynamicHeight = element.toDouble() * 5;
              }
            } else {
              dynamicHeight = element.toDouble() * 5;
            }

            return Align(
              alignment: Alignment.bottomCenter,
              child: CustomBox(
                height: dynamicHeight,
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
                  effects: [const ShakeEffect(), const FadeEffect(), const ShimmerEffect()]),
            );
          },
        ),
      ),
    );
  }
}
