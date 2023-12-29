import 'package:flutter/material.dart';

class TrainingTimerBody extends StatefulWidget {
  final String title;
  final String? subTitle;
  final int amount;
  final String unit;
  final TextButton? button;
  const TrainingTimerBody({super.key, required this.title, required this.amount, required this.unit, this.button, this.subTitle});

  @override
  State<TrainingTimerBody> createState() => _TrainingTimerBodyState();
}

class _TrainingTimerBodyState extends State<TrainingTimerBody> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: width*0.2 > 70 ? 70 : width*0.2),
          Text(widget.title, style: TextStyle(fontSize: width*0.1, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          if (widget.subTitle != null) SizedBox(width: width*0.9, child: Text(widget.subTitle!, textAlign: TextAlign.center, style: TextStyle(fontSize: width*0.06, fontWeight: FontWeight.bold))),
          Text(widget.amount.toString(), style: const TextStyle(fontSize: 200, fontWeight: FontWeight.bold)),
          Text(widget.unit, style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
          Container(
            height: width*0.2,
            alignment: Alignment.center,
            child: widget.button,
          ),
        ],
      ),
    );
  }
}