import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  final Widget child;
  final Color color;
  const Circle({
    super.key,
    this.child = const Text(""),
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final diameter = MediaQuery.of(context).size.width/8.5;
    return AnimatedContainer(
      alignment: Alignment.center,
      duration: const Duration(microseconds: 100),
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        shape: BoxShape.circle,
        color: color,
      ),
      child: child,
    );
  }
}
