import 'package:flutter/material.dart';
import 'package:movieapp/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeMovie',
      home: const HomePage(),
      debugShowCheckedModeBanner: true,
      theme: ThemeData(useMaterial3: true),
    );
  }
}
