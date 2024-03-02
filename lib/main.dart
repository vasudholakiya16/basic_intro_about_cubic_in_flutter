import 'dart:math' as math show Random;

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "basic introduction about bloc",
    theme: ThemeData(primaryColor: Colors.blue),
    debugShowCheckedModeBanner: false,
    home: const HomePage(),
  ));
}

const names = ['abc', 'def', 'ghi'];

// we nead to peack a rendom name
extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

//cubit class definition
class NamesCubit extends Cubit<String?> {
  NamesCubit() : super(null); // constructor of the cubit class

  // allow picking a rendom name in cubit
  void pickRandomName() => emit(names.getRandomElement());

  // void pickRandomName() {
  //  _state= 'aaa'; // not apply because of _state is a private class and it allow to get property only thae....
  // };
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// defint the cubit in your home page state
  late final NamesCubit cubit;
  //initialize the cubit in initState
  @override
  void initState() {
    super.initState();
    cubit = NamesCubit();
  }

  @override
  void dispose() {
    cubit.close(); // dont forgate to close the cubit in dispose()
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      // streamBuilder of body of scafold
      body: StreamBuilder<String?>(
        stream: cubit.stream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          final button = TextButton(
            onPressed: () => cubit.pickRandomName(),
            child: const Text('pick a rendom name'),
          );
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return button;
            case ConnectionState.waiting:
              return button;
            case ConnectionState.active: // Handle various connection states
              return Column(
                children: [
                  Text(snapshot.data ?? ' '),
                  button,
                ],
              );
            case ConnectionState.done:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
