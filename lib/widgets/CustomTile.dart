import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final String? trailing;
  final String image;
  final VoidCallback onTap;
  final bool addForwardIcon;

  const CustomTile({
    Key? key,
    required this.title,
    this.trailing,
    required this.image,
    required this.onTap,
    this.addForwardIcon = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width > 300 ? 300 : MediaQuery.sizeOf(context).width;
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
        foregroundColor: Colors.black,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*0.01),
        child: Column(
          children: [
            SizedBox(height: width*0.05),
            Row(
              children: [
                Image.asset(image, height: width*0.1),
                SizedBox(width: width*0.025),
                addForwardIcon
                  ? Row(
                      children: [
                        Text(title, style: TextStyle(fontSize: width*0.07)),
                        SizedBox(width: width*0.05),
                        Icon(Icons.arrow_forward_ios, size: width*0.1),
                      ],
                    )
                  : Expanded(child: Text(title, style: TextStyle(fontSize: width*0.07))),
                Text(trailing ?? "", style: TextStyle(fontSize: width*0.07, fontWeight: FontWeight.w300)),
              ],
            ),
            SizedBox(height: width*0.05),
            Container(
              color: Colors.black,
              height: 1,
              width: MediaQuery.sizeOf(context).width,
            )
          ],
        ),
      ),
    );
  }
}
