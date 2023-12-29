import 'package:bloc/bloc.dart';
import 'package:workouts_at_home/data_provider/DataProvider.dart';

part 'BMI_state.dart';

class BMICubit extends Cubit<BMIState> {
  final DataProvider dataProvider;
  BMICubit(this.dataProvider) : super(BMIState(age: 0, weight: 0)) {
    _init();
  }

  _init() async {
    final age = await getAge();
    final weight = await getWeight();
    emit(state.copyWith(age: age, weight: weight));
  }

  setAge(int age) {
    dataProvider.setAge(age);
    emit(state.copyWith(age: age));
  }

  getAge() async {
    emit(state.copyWith(age: await dataProvider.getAge()));
  }

  setWeight(int weight) {
    dataProvider.setWeight(weight);
    emit(state.copyWith(weight: weight));
  }

  getWeight() async {
    emit(state.copyWith(weight: await dataProvider.getWeight()));
  }
}
