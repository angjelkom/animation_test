import 'dart:io';

import 'package:animation_test/manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';

import 'board_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const ProviderScope(child: Game()),
    );
  }
}

class Game extends ConsumerStatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameState();
}

class _GameState extends ConsumerState<Game> with TickerProviderStateMixin {
  //The main contoller used to move the the tiles
  late AnimationController _moveController = AnimationController(
    duration: const Duration(milliseconds: 100),
    vsync: this,
  )..addStatusListener((status) {
    if (status == AnimationStatus.completed) {
      ref.read(simpleManager.notifier).setSimple();
    }
  });

  void regenerate(){
    _moveController.dispose();
    _moveController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        ref.read(simpleManager.notifier).setSimple();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (RawKeyEvent event) {
        ref.read(simpleManager.notifier).setSimple();
        _moveController
            .forward(from: 0.0)
            .orCancel;
      },
      child: SwipeDetector(
        onSwipe: Platform.isAndroid || Platform.isIOS
            ? (direction, offset) {
          ref.read(simpleManager.notifier).setSimple();
          _moveController
              .forward(from: 0.0)
              .orCancel;
        }
            : null,
        child: Scaffold(
          backgroundColor: Colors.red,
          body: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Center(
              child: Stack(
                children: [
                  TileBoardWidget(moveController: _moveController)
                ],
              ),
            )
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () {
                regenerate();
              },
              child: const Icon(Icons.arrow_upward)),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _moveController.dispose();
    super.dispose();
  }
}
