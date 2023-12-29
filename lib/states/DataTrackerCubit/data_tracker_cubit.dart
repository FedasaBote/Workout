import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:workouts_at_home/data_provider/DataProvider.dart';

part 'data_tracker_state.dart';

class DataTrackerCubit extends Cubit<DataTrackerState> {
  final DataProvider _dataProvider;
  DataTrackerCubit(this._dataProvider) : super(DataTrackerState([])) {
    getAllDaysData();
  }

  getAllDaysData() async {
    DateTime firstTime = await _dataProvider.getFirstTime();
    DateTime now = DateTime.now();
    final days = now.difference(firstTime).inDays+1;

    final List<bool?> allDaysData = [];
    for (var day = 1; day <= max(7, days); day++) {
      if (day < days) {
        bool isWorkedOut = await _dataProvider.getDayData(day);
        allDaysData.add(isWorkedOut);
      } else if (day == days) {
        bool isWorkedOut = await _dataProvider.getDayData(day);
        allDaysData.add(isWorkedOut ? true : null);
      } else {
        allDaysData.add(null);
      }
    }
    emit(DataTrackerState(allDaysData));
  }

  setCompleted() async {
    await _dataProvider.setCompleted();
    getAllDaysData();
  }
}
