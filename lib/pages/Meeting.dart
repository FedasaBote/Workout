import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../layouts/HomeLayout.dart';
import '../states/LanguageCubit/language_cubit.dart';
import '../states/TrainingTimerCubit/training_timer_cubit.dart';
import '../utils/enums.dart';

class Meeting extends StatefulWidget {
  const Meeting({super.key});

  @override
  State<Meeting> createState() => _MeetingState();
}

class _MeetingState extends State<Meeting> {
  int _selectedLevel = -1;
  final Map<int, TrainingLevel> levels = {
    0: TrainingLevel.easy,
    1: TrainingLevel.mid,
    2: TrainingLevel.adv
  };

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, languageState) {
        return SafeArea(
          child: Scaffold(
            body: ListView(
              children: [
                SizedBox(height: width * 0.15),
                Text(languageState.language == Language.eng ? 'Your Level?'.toUpperCase() : 'ВАШ УРОВЕНЬ?',
                    style: TextStyle(fontSize: width*0.1, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                SizedBox(height: width * 0.075),
                ...List.generate(3, (index) => GestureDetector(
                  onTap: () => setState(() => _selectedLevel = index),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: width * 0.02),
                    padding: EdgeInsets.only(top: width * 0.01),
                    decoration: _selectedLevel != index
                        ? null
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(width * 0.1),
                            border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiary,
                                width: 3),
                            color: _selectedLevel == index
                                ? Theme.of(context)
                                    .colorScheme
                                    .tertiary
                                    .withOpacity(0.2)
                                : Colors.transparent,
                          ),
                    child: Image.asset(
                      'assets/images/levels/${levels[index]!.name}_${languageState.language.name}.png',
                      fit: BoxFit.fitWidth
                    ),
                  ),
                )),
                SizedBox(height: width * 0.1),
                TextButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.transparent),
                    foregroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  onPressed: _selectedLevel == -1
                      ? null
                      : () {
                        BlocProvider.of<TrainingTimerCubit>(context).setLevel(levels[_selectedLevel]!);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HomeLayout()));
                      },
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                      padding: EdgeInsets.symmetric(vertical: width * 0.02),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: _selectedLevel == -1
                              ? Colors.grey
                              : Theme.of(context).colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(width * 0.05)),
                      child: Text(languageState.language == Language.eng ? "Next".toUpperCase() : 'Далее',
                          style: TextStyle(fontSize: width * 0.1, fontWeight: FontWeight.w300))),
                ),
                SizedBox(height: width * 0.1)
              ],
            ),
          ),
        );
      },
    );
  }
}
