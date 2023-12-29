import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../states/LanguageCubit/language_cubit.dart';
import '../states/TrainingTimerCubit/training_timer_cubit.dart';
import '../utils/enums.dart';
import '../widgets/StrokeText.dart';
import '../widgets/CustomCalendar.dart';
import '../widgets/StartWorkout.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final levels = {
    TrainingLevel.easy: {'eng': 'Beginner', 'rus': 'Начинающий'},
    TrainingLevel.mid: {'eng': 'Intermediate', 'rus': 'Промежуточный'},
    TrainingLevel.adv: {'eng': 'Advanced', 'rus': 'Продвинутый'},
  };

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width > 500 ? 500 : MediaQuery.of(context).size.width;
    return ListView(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Image.asset('assets/images/header_bg.png', height: width*0.45, width: MediaQuery.sizeOf(context).width, fit: BoxFit.fill),
            Column(
              children: [
                SizedBox(
                  height: width*0.4,
                  child: BlocBuilder<LanguageCubit, LanguageState>(
                    builder: (context, langState) {
                      return Column(
                        children: [
                          SizedBox(height: width*0.05),
                          StrokeText(text: langState.language == Language.eng ? 'Workouts At home'.toUpperCase() : 'ТРЕНИРОВКИ ДОМА', size: width / 12),
                          BlocBuilder<TrainingTimerCubit, TrainingTimerState>(
                            builder: (context, state) {
                              return StrokeText(
                                text: levels[state.level]==null ? '' : levels[state.level]![langState.language.name]!,
                                size: width / 12
                              );
                            },
                          ),
                          SizedBox(height: width*0.025),
                          Image.asset("assets/images/icons/dumbbells.png", height: width*0.075, color: Colors.white),
                        ],
                      );
                    },
                  ),
                ),
                const CustomCalendar(),
              ],
            ),
          ],
        ),
        SizedBox(height: width*0.05),
        const StartWork(),
        SizedBox(height: width*0.1),
      ],
    );
  }
}
