import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workouts_at_home/layouts/HomeLayout.dart';
import 'package:workouts_at_home/states/LanguageCubit/language_cubit.dart';
import 'package:workouts_at_home/states/TrainingTimerCubit/training_timer_cubit.dart';
import 'package:workouts_at_home/widgets/SelectorDialog.dart';

import '../utils/enums.dart';
import 'CustomTile.dart';

class FunctionalSettings extends StatelessWidget {
  const FunctionalSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainingTimerCubit, TrainingTimerState>(
      builder: (context, timerState) {
        return BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, langState) {
            return Column(
              children: [
                CustomTile(
                  title: langState.language == Language.eng ? "REST TIME" : "ВРЕМЯ ОТДЫХА",
                  trailing: "${timerState.restTime} ${langState.language == Language.eng ? 'SEC' : 'СЕК'}",
                  image: "assets/images/icons/rest.png",
                  onTap: () {
                    showDialog(context: context, builder: (context) => SelectionDialog(title: langState.language == Language.eng ? 'Change Rest Time' : 'Изменение времени отдыха', options: [
                      Option(option: '30 ${langState.language == Language.eng ? 'SEC' : 'СЕК'}', onTap: () {
                        BlocProvider.of<TrainingTimerCubit>(context).setRestTime(30);
                      }),
                      Option(option: '45 ${langState.language == Language.eng ? 'SEC' : 'СЕК'}', onTap: () {
                        BlocProvider.of<TrainingTimerCubit>(context).setRestTime(45);
                      }),
                      Option(option: '60 ${langState.language == Language.eng ? 'SEC' : 'СЕК'}', onTap: () {
                        BlocProvider.of<TrainingTimerCubit>(context).setRestTime(60);
                      }),
                    ]));
                  }
                ),
                CustomTile(
                    title: langState.language == Language.eng ? "LEVEL" : "НАСТРОЙКА УРОВНЯ",
                    trailing: timerState.level == TrainingLevel.easy
                        ? langState.language == Language.eng ? 'BEGINNER' : 'Начинающий'
                        : timerState.level == TrainingLevel.mid
                            ? langState.language == Language.eng ? 'INTERMEDIATE' : 'Промежуточный'
                            : langState.language == Language.eng ? 'ADVANCED' : 'Продвинутый',
                    image: "assets/images/icons/level.png",
                    onTap: () {
                      showDialog(context: context, builder: (context) => SelectionDialog(title: langState.language == Language.eng ? 'Change Level' : 'Изменить уровень', options: [
                        Option(option: langState.language == Language.eng ? 'BEGINNER' : 'Начинающий', onTap: () {
                          BlocProvider.of<TrainingTimerCubit>(context).setLevel(TrainingLevel.easy);
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeLayout()));
                        }),
                        Option(option: langState.language == Language.eng ? 'INTERMEDIATE' : 'Промежуточный', onTap: () {
                          BlocProvider.of<TrainingTimerCubit>(context).setLevel(TrainingLevel.mid);
                        }),
                        Option(option: langState.language == Language.eng ? 'ADVANCED' : 'Продвинутый', onTap: () {
                          BlocProvider.of<TrainingTimerCubit>(context).setLevel(TrainingLevel.adv);
                        }),
                      ]));
                    },
                ),
                CustomTile(
                    title: langState.language == Language.eng ? "LANGUAGE" : "ВЫБОР ЯЗЫКА",
                    trailing: langState.language == Language.eng ? 'ENG' : 'РУССКИЙ',
                    image: "assets/images/icons/language.png",
                    onTap: () {
                      showDialog(context: context, builder: (context) => SelectionDialog(title: langState.language == Language.eng ? 'Change Language' : 'Изменение языка', options: [
                        Option(option: 'ENGLISH', onTap: () {
                          BlocProvider.of<LanguageCubit>(context).setLanguage(Language.eng);
                        }),
                        Option(option: 'РУССКИЙ', onTap: () {
                          BlocProvider.of<LanguageCubit>(context).setLanguage(Language.rus);
                        }),
                      ]));
                    }),
                SizedBox(
                  child: CustomTile(
                      title: langState.language == Language.eng ? "PREPAIR TIME" : "ОБРАТНЫЙ ОТЧЕТ",
                      trailing: "${timerState.prepareTime} ${langState.language == Language.eng ? 'SEC' : 'СЕК'}",
                      image: "assets/images/icons/time.png",
                      onTap: () {
                        showDialog(context: context, builder: (context) => SelectionDialog(title: langState.language == Language.eng ? 'Change Prepair Time' : 'Изменение времени подготовки', options: [
                          Option(option: '30 ${langState.language == Language.eng ? 'SEC' : 'СЕК'}', onTap: () {
                            BlocProvider.of<TrainingTimerCubit>(context).setPrepareTime(30);
                          }),
                          Option(option: '45 ${langState.language == Language.eng ? 'SEC' : 'СЕК'}', onTap: () {
                            BlocProvider.of<TrainingTimerCubit>(context).setPrepareTime(45);
                          }),
                          Option(option: '60 ${langState.language == Language.eng ? 'SEC' : 'СЕК'}', onTap: () {
                            BlocProvider.of<TrainingTimerCubit>(context).setPrepareTime(60);
                          }),
                        ]));
                      }),
                )
              ],
            );
          },
        );
      },
    );
  }
}
