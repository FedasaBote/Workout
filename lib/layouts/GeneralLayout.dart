import 'package:flutter/material.dart';

class GeneralLayout extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget footer;

  const GeneralLayout({super.key, this.appBar, required this.body, required this.footer});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: body,
        bottomNavigationBar: footer
      ),
    );
  }
}