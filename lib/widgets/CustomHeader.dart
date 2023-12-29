import 'package:flutter/material.dart';
import 'package:workouts_at_home/widgets/StrokeText.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final double? textSize;
  final String? bgImage;
  final String? icon;
  final double? iconSize;
  final double? height;
  final MainAxisAlignment? alignment;
  const CustomHeader({super.key, required this.text, this.bgImage, this.icon, this.alignment, this.iconSize, this.height, this.textSize});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImage ?? 'assets/images/header_bg.png'),
            fit: BoxFit.fill
          )
        ),
        child: Column(
          mainAxisAlignment: alignment ?? MainAxisAlignment.center,
          children: [
            StrokeText(text: text, size: textSize ?? 40),
            if (icon !=null) Image.asset(icon!, height: iconSize ?? 50)
          ],
        ),
      )
    );
  }
  
  @override
  Size get preferredSize => Size(double.infinity, height ?? 180);
}
