import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visualizer/provider/sort_provider.dart';
import 'package:visualizer/ui/bubblesort.dart';
import 'package:visualizer/ui/home.dart';
import 'package:visualizer/ui/insertion_sort.dart';
import 'package:visualizer/ui/selectionsort.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SortProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
