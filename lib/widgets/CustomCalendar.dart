import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../states/DataTrackerCubit/data_tracker_cubit.dart';
import 'SingleDay.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToEndWithAnimation();
    });
  }

  void _scrollToEndWithAnimation() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataTrackerCubit, DataTrackerState>(
      builder: (context, state) {
        var size = MediaQuery.of(context).size;
        return Container(
          height: size.width * 0.3,
          width: size.width * 0.96,
          padding: EdgeInsets.symmetric(vertical: size.width * 0.02, horizontal: size.width * 0.05),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(size.width * 0.15),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: state.allDays.length,
            itemBuilder: (context, index) {
              return SingleDay(
                day: index + 1,
                isDone: index >= state.allDays.length ? null : state.allDays[index],
              );
            },
          ),
        );
      },
    );
  }
}
