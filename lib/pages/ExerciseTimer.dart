import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workouts_at_home/data/workouts.dart';
import 'package:workouts_at_home/layouts/GeneralLayout.dart';
import 'package:workouts_at_home/layouts/HomeLayout.dart';
import 'package:workouts_at_home/states/DataTrackerCubit/data_tracker_cubit.dart';
import 'package:workouts_at_home/states/LanguageCubit/language_cubit.dart';
import 'package:workouts_at_home/states/TrainingTimerCubit/training_timer_cubit.dart';
import 'package:workouts_at_home/utils/enums.dart';
import 'package:workouts_at_home/widgets/CustomHeader.dart';
import 'package:workouts_at_home/widgets/FooterButton.dart';
import 'package:workouts_at_home/widgets/TrainingTimerBody.dart';

import '../widgets/WorkoutCompletedDialog.dart';

class ExerciseTimer extends StatefulWidget {
  const ExerciseTimer({super.key});

  @override
  State<ExerciseTimer> createState() => _ExerciseTimerState();
}

class _ExerciseTimerState extends State<ExerciseTimer> {
  bool _dialogShown = false;
  @override
  void initState() {
    super.initState();
    final prepareTime = BlocProvider.of<TrainingTimerCubit>(context).state.prepareTime;
    BlocProvider.of<TrainingTimerCubit>(context).reset();
    BlocProvider.of<TrainingTimerCubit>(context).startTimer(prepareTime);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width > 500 ? 500 : MediaQuery.of(context).size.width;
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, langState) {
        return BlocConsumer<TrainingTimerCubit, TrainingTimerState>(
          listener: (context, state) {
            if (state.curWorkoutId == 12) {
              if (!_dialogShown) {
                context.read<DataTrackerCubit>().setCompleted();
                _dialogShown = true;
                showDialog(
                        context: context,
                        builder: (context) {
                          return const WorkoutCompletedDialog();
                        })
                    .then((value) => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeLayout()), (route) => false));
              }
            }
          },
          builder: (context, state) {
            if (state.curWorkoutId == workouts[langState.language.name]![state.level.name]!.length) {
              return const Scaffold();
            }
            if (state.restOrPrepare) {
              return GeneralLayout(
                appBar: state.curWorkoutId == 0
                    ? CustomHeader(
                      text: langState.language == Language.eng ? 'Get Ready' : 'ПРИГОТОВТЕСЬ',
                      height: width*0.4,
                    )
                    : CustomHeader(
                        text: langState.language == Language.eng ? 'Pause' : 'ПАУЗА',
                        icon: 'assets/images/icons/pause.png',
                        height: width*0.5,
                        textSize: 100),
                body: TrainingTimerBody(
                  amount: state.curAmount,
                  unit: langState.language == Language.eng ? 'SECONDS' : 'СЕКУНД',
                  title: state.curWorkoutId == 0
                      ? langState.language == Language.eng ? 'Time to Start'.toUpperCase() : 'ВРЕМЯ ДО НАЧАЛА'
                      : langState.language == Language.eng ? 'Rest'.toUpperCase() : 'ОТДОХНИТЕ',
                  subTitle: state.curWorkoutId == 0
                      ? null
                      : langState.language == Language.eng ? 'Recover Your Breathing'.toUpperCase() : 'ВОССТАНОВИТЕ ДЫХАНИЕ',
                ),
                footer: FooterButton(
                    text: langState.language == Language.eng ? 'Skip' : 'ПРОПУСТИТЬ',
                    onPressed: () {
                      BlocProvider.of<TrainingTimerCubit>(context).next();
                    }),
              );
            }

            final workout = workouts[context.read<LanguageCubit>().state.language.name]![context.read<TrainingTimerCubit>().state.level.name]![context.read<TrainingTimerCubit>().state.curWorkoutId];
            return GeneralLayout(
              appBar: CustomHeader(
                  text: langState.language == Language.eng ? 'Training Started' : 'ТРЕНИРОВКА НАЧАЛАСЬ',
                  icon: 'assets/images/icons/dumbbells.png',
                  height: 200,
                  textSize: 50,
                  iconSize: 30),
              body: TrainingTimerBody(
                  amount: state.curAmount,
                  unit: workout['unit'].toUpperCase(),
                  title: workout['name'].toUpperCase(),
                  button: workout['unit'] == 'reps' || workout['unit'] == 'повторений'
                      ? null
                      : TextButton(
                          onPressed: () {
                            if (BlocProvider.of<TrainingTimerCubit>(context)
                                .state
                                .isPaused) {
                              BlocProvider.of<TrainingTimerCubit>(context)
                                  .resumeTimer();
                            } else {
                              BlocProvider.of<TrainingTimerCubit>(context)
                                  .pauseTimer();
                            }
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 60)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context).colorScheme.tertiary),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ))),
                          child: Text(
                              context.read<TrainingTimerCubit>().state.isPaused
                                  ? langState.language == Language.eng ? 'Start' : 'Старт'
                                  : langState.language == Language.eng ? 'Stop' : 'Стоп',
                              style: const TextStyle(fontSize: 32)),
                        )),
              footer: FooterButton(
                  text: langState.language == Language.eng ? 'Next' : 'Далее',
                  onPressed: () {
                    BlocProvider.of<TrainingTimerCubit>(context).next();
                  }),
            );
          },
        );
      },
    );
  }
}
