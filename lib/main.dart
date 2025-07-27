import 'package:busha_task/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Busha Task',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Satoshi",
      ),
      home: const MainScreen(),
    );
  }
}
