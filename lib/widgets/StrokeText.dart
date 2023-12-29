import 'package:flutter/material.dart';

class StrokeText extends StatelessWidget {
  final String text;
  final double size;
  const StrokeText({super.key, required this.text, required this.size});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: size,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.0
              ..color =
                  Colors.black,
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: size,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}