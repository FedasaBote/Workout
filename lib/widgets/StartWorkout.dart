import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workouts_at_home/pages/Trainings.dart';
import 'package:workouts_at_home/states/LanguageCubit/language_cubit.dart';
import 'package:workouts_at_home/utils/enums.dart';

class StartWork extends StatelessWidget {
  const StartWork({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width > 300 ? 300 : MediaQuery.of(context).size.width;
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, langState) {
        return Container(
          clipBehavior: Clip.hardEdge,
          width: MediaQuery.sizeOf(context).width * 0.9,
          padding: EdgeInsets.only(top: width * 0.05),
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.05),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * 0.1),
            border: Border.all(color: Colors.black),
          ),
          child: Column(
            children: [
              Text(
                langState.language == Language.eng ? "PRESS TO START" : 'НАЖМИТЕ ЧТОБЫ НАЧАТЬ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: width * 0.07,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: width * 0.025),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Trainings()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05,
                    vertical: width * 0.0375,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width*0.05),
                    color: const Color(0xFF729CF0),
                  ),
                  child: Text(
                    langState.language == Language.eng ? "START WORKOUT" : 'СТАРТ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.09,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: width * 0.025),
              Image.asset('assets/images/workout.jpg',
                  width: MediaQuery.sizeOf(context).width * 0.9, fit: BoxFit.fill)
            ],
          ),
        );
      },
    );
  }
}
