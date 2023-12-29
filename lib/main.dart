import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/enums.dart';
import '../data_provider/DataProvider.dart';
import '../pages/Meeting.dart';
import '../states/BMICubit/BMI_cubit.dart';
import '../states/LanguageCubit/language_cubit.dart';
import '../states/TrainingTimerCubit/training_timer_cubit.dart';
import '../states/DataTrackerCubit/data_tracker_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  final dataProvider = DataProvider();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<TrainingTimerCubit>(
        lazy: false,
        create: (context) => TrainingTimerCubit(dataProvider),
      ),
      BlocProvider<LanguageCubit>(
        create: (context) => LanguageCubit(dataProvider),
      ),
      BlocProvider(
        lazy: false,
        create: (context) => DataTrackerCubit(dataProvider),
      ),
      BlocProvider(
        create: (context) => BMICubit(dataProvider),
      )
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                fontFamily: state.language == Language.eng ? 'Georama' : null,
                scaffoldBackgroundColor: Colors.white,
                colorScheme: const ColorScheme(
                    brightness: Brightness.light,
                    primary: Color(0xFF6A95EA),
                    onPrimary: Colors.white,
                    secondary: Color(0xFF85AEFF),
                    onSecondary: Colors.black,
                    tertiary: Color(0xFFFFB4B4),
                    error: Colors.redAccent,
                    onError: Colors.red,
                    background: Colors.white,
                    onBackground: Colors.black,
                    surface: Colors.white,
                    onSurface: Colors.black,
                ),
            ),
          home: const Meeting(),
        );
      },
    );
  }
}
