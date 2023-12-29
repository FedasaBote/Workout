import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workouts_at_home/layouts/GeneralLayout.dart';
import 'package:workouts_at_home/pages/Menu.dart';
import 'package:workouts_at_home/pages/Settings.dart';
import 'package:workouts_at_home/states/LanguageCubit/language_cubit.dart';
import 'package:workouts_at_home/utils/enums.dart';
import 'package:workouts_at_home/widgets/CustomHeader.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _currentIndex = 0;
  late final List<Widget> _children = [
    const Menu(),
    const Settings()
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, langState) {
        return GeneralLayout(
          appBar: _currentIndex == 0
            ? null
            : CustomHeader(
              text: langState.language == Language.eng ? 'SETTINGS' : 'НАСТРОЙКИ',
              icon: 'assets/images/icons/settings.png',
              textSize: width * 0.1 > 50 ? 50 : width * 0.1,
              iconSize: width * 0.1 > 50 ? 50 : width * 0.1,
              height: width * 0.4 > 150 ? 150 : width * 0.4,
            ),
        body: _children[_currentIndex],
        footer: Container(
          height: width * 0.2,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: width * 0.05,
                offset: Offset(0, -width * 0.01))
          ]),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (value) => setState(() => _currentIndex = value),
            items: [
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: width*0.01),
                    child: Image.asset('assets/images/icons/trainings.png',
                        height: width*0.1, color: Colors.black),
                  ),
                  label: langState.language == Language.eng ? 'Training' : 'Тренировка'),
              BottomNavigationBarItem(
                  icon: Image.asset('assets/images/icons/settings.png',
                      height: width*0.1, color: Colors.black),
                  label: langState.language == Language.eng ? 'Settings' : 'Настройки'),
            ]
          )
        ));
      },
    );
  }
}
