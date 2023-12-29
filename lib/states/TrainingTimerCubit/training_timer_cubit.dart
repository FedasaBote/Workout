import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workouts_at_home/data/workouts.dart';
import 'package:workouts_at_home/data_provider/DataProvider.dart';
import 'package:workouts_at_home/utils/enums.dart';

part 'training_timer_state.dart';

class TrainingTimerCubit extends Cubit<TrainingTimerState> {
  final DataProvider dataProvider;
  Timer? _timer;
  TrainingTimerCubit(this.dataProvider) : super(TrainingTimerInitial()) {
    _init();
  }

  _init() async {
    final level = await dataProvider.getLevel();
    final prepareTime = await dataProvider.getPrepareTime();
    final restTime = await dataProvider.getRestTime();
    emit(state.copyWith(level: level, prepareTime: prepareTime, restTime: restTime));
  }

  setLevel(TrainingLevel level) {
    dataProvider.setLevel(level);
    emit(state.copyWith(level: level));
  }
  getLevel() async {
    emit(state.copyWith(level: await dataProvider.getLevel()));
  }

  setPrepareTime(int prepareTime) {
    dataProvider.setPrepareTime(prepareTime);
    emit(state.copyWith(prepareTime: prepareTime));
  }
  getPrepareTime() async {
    emit(state.copyWith(prepareTime: await dataProvider.getPrepareTime()));
  }

  setRestTime(int restTime) {
    dataProvider.setRestTime(restTime);
    emit(state.copyWith(restTime: restTime));
  }
  getRestTime() async {
    emit(state.copyWith(restTime: await dataProvider.getRestTime()));
  }

  setCurWorkoutId(int curWorkoutId) {
    emit(state.copyWith(curWorkoutId: curWorkoutId));
  }

  setRestOrPrepare(bool restOrPrepare) {
    emit(state.copyWith(restOrPrepare: restOrPrepare));
  }

  setCurAmount(int curAmount) {
    emit(state.copyWith(curAmount: curAmount));
  }

  startTimer(int initialAmount) async {
    emit(state.copyWith(curAmount: initialAmount, isPaused: false));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.curAmount > 0 && !state.isPaused) {
        emit(state.copyWith(curAmount: state.curAmount - 1));
      } else {
        next();
      }
    });
  }

  pauseTimer() {
    _timer?.cancel();
    emit(state.copyWith(isPaused: true));
  }

  resumeTimer() {
    startTimer(state.curAmount);
  }

  next() async {
    _timer?.cancel();
    emit(state.copyWith(isPaused: true));
    if (state.restOrPrepare) {
      emit(state.copyWith(restOrPrepare: false));
      if (state.curWorkoutId < workouts.length) {
        final workout = workouts['eng']![state.level.name]![state.curWorkoutId];
        if (workout['unit'] == 'seconds') {
          startTimer(workout['amount']);
        } else {
          setCurAmount(workout['amount']);
        }
      }
    } else {
      emit(state.copyWith(restOrPrepare: true, curWorkoutId: state.curWorkoutId + 1));
      startTimer(state.restTime);
    }
  }

  reset() {
    _timer?.cancel();
    emit(state.copyWith(isPaused: true, restOrPrepare: true, curWorkoutId: 0));
  }
}
