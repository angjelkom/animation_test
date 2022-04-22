
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class Simple {
  final int age;
  final String name;
  final bool fine;

  Simple(this.age, this.name, this.fine);
}
class SimpleManager extends StateNotifier<List<Simple>> {
  SimpleManager() : super([]);

  void setSimple(){
    state = List.generate(Random().nextInt(16), (index) => Simple(28, "${Random().nextInt(1000)}", true));
  }
}

final simpleManager =
StateNotifierProvider<SimpleManager, List<Simple>>((ref) {
  return SimpleManager();
});