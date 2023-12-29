import 'package:flutter/material.dart';

import 'Circle.dart';

class SingleDay extends StatelessWidget {
  final int day;
  final bool? isDone;
  const SingleDay({
    super.key,
    required this.day, this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width > 300 ? 300 : MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width*0.0025),
      child: Column(
        children: [
          Circle(
            color: isDone == null ? Colors.white : isDone == true ? Color(0xFFABFFA4) : Color(0xFFFF8B8B),
            child: Text(day.toString(), style: TextStyle(fontSize: width*0.075),),
          ),
          SizedBox(height: width*0.01),
          isDone == null
              ? const Circle()
              : Circle(
                child: isDone!
                    ? Icon(Icons.check, size: width*0.075)
                    : Icon(Icons.close, size: width*0.075),
              )
        ],
      ),
    );
  }
}
