import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workouts_at_home/states/LanguageCubit/language_cubit.dart';
import 'package:workouts_at_home/utils/enums.dart';

class Metrics extends StatelessWidget {
  final String value;
  final String label;
  final VoidCallback onPressed;
  const Metrics({
    super.key,
    required this.label,
    required this.value,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: width * 0.45-1,
        child: Column(
          children: [
            TextField(
              controller: TextEditingController(text: value),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: width * 0.02, horizontal: width * 0.02),
              ),
              enabled: false,
              style: TextStyle(
                fontSize: width * 0.25 > 70 ? 70 : width * 0.25,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: width * 0.05 > 30 ? 30 : width * 0.05,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            BlocBuilder<LanguageCubit, LanguageState>(
              builder: (context, state) {
                return Text(state.language == Language.eng ? '(edit)' : '(ред.)', style: TextStyle(
                  fontSize: width * 0.03 > 20 ? 20 : width * 0.03,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ));
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
