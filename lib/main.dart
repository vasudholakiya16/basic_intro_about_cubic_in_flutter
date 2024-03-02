import 'dart:math' as math show Random;

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "basic introduction about bloc",
    theme: ThemeData(primaryColor: Colors.blue),
    debugShowCheckedModeBanner: false,
    home: const HomePage(),
  ));
}

const name = ['abc', 'def', 'ghi'];

// we nead to peack a rendom name
extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
    );
  }
}
