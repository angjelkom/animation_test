import 'dart:math';

import 'package:animation_test/manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'animated_tile.dart';

class TileBoardWidget extends ConsumerWidget {
  const TileBoardWidget(
      {Key? key, required this.moveController})
      : super(key: key);

  final AnimationController moveController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager = ref.watch(simpleManager);

    final size = max(
        290.0,
        min((MediaQuery.of(context).size.shortestSide * 0.90).floorToDouble(),
            460.0));

    final _sizePerTile = (size / 4).floorToDouble();
    final tileSize = _sizePerTile - 12.0 - (12.0 / 4);
    final _size = _sizePerTile * 4;
    return SizedBox(
      width: _size,
      height: _size,
      child: Stack(
        children: [
          ...List.generate(manager.length, (index) => AnimatedTile(moveController: moveController, child: Text(manager[index].name), size: tileSize,),)
        ],
      ),
    );
  }
}
