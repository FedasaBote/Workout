import 'package:flutter/material.dart';

class FooterButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const FooterButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
        height: width*0.2,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, -3)
            )
          ]
        ),
        child: TextButton(
          onPressed: onPressed,
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.transparent),
            foregroundColor: MaterialStatePropertyAll(Colors.black),
            elevation: MaterialStatePropertyAll(0)
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: width*0.05, vertical: width*0.0025),
            padding: const EdgeInsets.symmetric(vertical: 0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(width*0.05),
            ),
            child: Text(text, style: TextStyle(fontSize: width*0.1))
          ),
        )
      );
  }
}