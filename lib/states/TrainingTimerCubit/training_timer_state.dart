part of 'training_timer_cubit.dart';

class TrainingTimerState {
  final TrainingLevel level;
  final int prepareTime;
  final int restTime;
  final int curWorkoutId;
  final bool restOrPrepare;
  int curAmount;
  final bool isPaused;
  TrainingTimerState({required this.level, required this.prepareTime, required this.restTime, required this.curWorkoutId, required this.restOrPrepare, required this.curAmount, required this.isPaused});

  TrainingTimerState copyWith({
    TrainingLevel? level,
    int? prepareTime,
    int? restTime,
    int? curWorkoutId,
    bool? restOrPrepare,
    int? curAmount,
    bool? isPaused,
  }) {
    return TrainingTimerState(
      level: level ?? this.level,
      prepareTime: prepareTime ?? this.prepareTime,
      restTime: restTime ?? this.restTime,
      curWorkoutId: curWorkoutId ?? this.curWorkoutId,
      restOrPrepare: restOrPrepare ?? this.restOrPrepare,
      curAmount: curAmount ?? this.curAmount,
      isPaused: isPaused ?? this.isPaused,
    );
  }
}

final class TrainingTimerInitial extends TrainingTimerState {
  TrainingTimerInitial() : super(prepareTime: 30, restTime: 30, curWorkoutId: 0, restOrPrepare: true, curAmount: 0, isPaused: true, level: TrainingLevel.none);
}
