import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/workouts.dart';
import '../layouts/GeneralLayout.dart';
import '../pages/ExerciseTimer.dart';
import '../states/LanguageCubit/language_cubit.dart';
import '../states/TrainingTimerCubit/training_timer_cubit.dart';
import '../utils/enums.dart';
import '../widgets/CustomHeader.dart';
import '../widgets/FooterButton.dart';

class Trainings extends StatelessWidget {
  const Trainings({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width > 400
        ? 400
        : MediaQuery.of(context).size.width;
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, langState) {
        return BlocBuilder<TrainingTimerCubit, TrainingTimerState>(
          builder: (context, state) {
            return GeneralLayout(
                appBar: CustomHeader(
                    bgImage:
                        'assets/images/levels/${state.level.name}_day_${langState.language.name}.png',
                    text: '',
                    height: MediaQuery.sizeOf(context).width * 0.4),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.all(width * 0.03),
                          child: Text(langState.language == Language.eng ? 'Workouts:' : 'Упражнения :',
                              style: TextStyle(fontSize: width*0.075, fontWeight: FontWeight.bold))),
                      ...List.generate(
                          workouts[langState.language.name]![state.level.name]!.length,
                          (index) => Padding(
                                padding: EdgeInsets.symmetric(vertical: width*0.01),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        alignment: Alignment.centerRight,
                                        width: width*0.1,
                                        child: Text(
                                            '${workouts[langState.language.name]![state.level.name]![index]['id']}.',
                                            style: TextStyle(
                                                fontSize: width*0.05 > 30 ? 30 : width*0.05,
                                                fontWeight: FontWeight.bold))),
                                    SizedBox(width: width*0.05 > 10 ? 10 : width*0.05),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*0.8,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "${workouts[langState.language.name]![state.level.name]![index]['name']}",
                                              style: TextStyle(
                                                  fontSize: width*0.05,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              "${workouts[langState.language.name]![state.level.name]![index]['amount']} ${workouts[langState.language.name]![state.level.name]![index]['unit']}",
                                              style: TextStyle(fontSize: width*0.05)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                footer: FooterButton(
                    text: langState.language == Language.eng ? 'Start' : 'Начать',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ExerciseTimer()));
                    }));
          },
        );
      },
    );
  }
}
