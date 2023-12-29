import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../states/BMICubit/BMI_cubit.dart';
import '../states/LanguageCubit/language_cubit.dart';
import '../utils/enums.dart';
import 'InputDialog.dart';
import 'Metrics.dart';

class BMIInfo extends StatelessWidget {
  const BMIInfo({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width > 300 ? 300 : MediaQuery.of(context).size.width;
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, langState) {
        return BlocBuilder<BMICubit, BMIState>(
          builder: (context, state) {
            return IntrinsicHeight(
              child: Row(
                children: [
                  Metrics(
                    label: langState.language == Language.eng ? "Age" : "Возраст",
                    value: state.age.toString(),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => InputDialog(
                              label: langState.language == Language.eng ? 'Age' : "Возраст",
                              value: state.age.toString()
                          )
                      ).then((age) {
                        if (age != null) {
                          context.read<BMICubit>().setAge(age);
                        }
                      });
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: width * 0.02),
                    child: const VerticalDivider(width: 1, color: Colors.black),
                  ),
                  Metrics(
                    label: langState.language == Language.eng ? "Weight" : 'Ваш вес',
                    value: state.weight.toString(),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => InputDialog(
                            label: langState.language == Language.eng ? "Weight" : 'Ваш вес',
                            value: state.weight.toString()
                          )
                      ).then((weight) {
                        if (weight != null) {
                          context.read<BMICubit>().setWeight(weight);
                        }
                      });
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
