part of 'BMI_cubit.dart';

class BMIState {
  final int age;
  final int weight;
  const BMIState({required this.age, required this.weight});

  BMIState copyWith({
    int? age,
    int? weight,
  }) {
    return BMIState(
      age: age ?? this.age,
      weight: weight ?? this.weight,
    );
  }
}