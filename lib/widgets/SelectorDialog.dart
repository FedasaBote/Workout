import 'package:flutter/material.dart';

class SelectionDialog extends StatelessWidget {
  final String title;
  final List<Option> options;
  const SelectionDialog({super.key, required this.options, required this.title});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width > 300 ? 300 : MediaQuery.sizeOf(context).width;
    return AlertDialog(
      title: Text(title, style: TextStyle(fontSize: width*0.07)),
      content: SingleChildScrollView(
        child: Column(
          children: options
        ),
      ),
    );
  }
}

class Option extends StatelessWidget {
  final String option;
  final VoidCallback onTap;

  const Option({
    super.key, 
    required this.option,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width > 300 ? 300 : MediaQuery.sizeOf(context).width;
    return ListTile(
      title: Text(option, style: TextStyle(fontSize: width*0.07)),
      onTap: () {
        onTap();
        Navigator.of(context).pop();
      },
    );
  }
}