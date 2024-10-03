import 'package:flutter/material.dart';
import 'fake.dart'; // Import the fake.dart file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FakeSchedulePage(), // Set FakeScreen as the home screen
    );
  }
}
