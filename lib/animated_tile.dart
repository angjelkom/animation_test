
import 'package:flutter/material.dart';

class AnimatedTile extends AnimatedWidget {
  //We use Listenable.merge in order to update the animated widget when both of the controllers have change
  AnimatedTile(
      {Key? key,
        required this.moveController,
        required this.child,
        required this.size})
      : super(
      key: key,
      listenable: moveController);

  final Widget child;
  final AnimationController moveController;
  final double size;

  //top tween used to move the tile from top to bottom
  late final Animation<double> top = Tween<double>(
    begin: 100.0,
    end: 100.0,
  ).animate(
    CurvedAnimation(
      parent: moveController,
      curve: const Interval(
        0.0,
        1.0,
        curve: Curves.linear,
      ),
    ),
  ),
  //left tween used to move the tile from left to right
      left = Tween<double>(
        begin: 100.0,
        end: 100.0,
      ).animate(
        CurvedAnimation(
          parent: moveController,
          curve: const Interval(
            0.0,
            1.0,
            curve: Curves.linear,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: top.value,
        left: left.value,
        //Only use scale animation if the tile was merged
        child: child);
  }
}