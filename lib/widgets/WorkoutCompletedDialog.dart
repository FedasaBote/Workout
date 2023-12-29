import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workouts_at_home/states/LanguageCubit/language_cubit.dart';
import 'package:workouts_at_home/utils/enums.dart';

class WorkoutCompletedDialog extends StatefulWidget {
  const WorkoutCompletedDialog({super.key});

  @override
  State<WorkoutCompletedDialog> createState() => _WorkoutCompletedDialogState();
}

class _WorkoutCompletedDialogState extends State<WorkoutCompletedDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          padding: const EdgeInsets.all(24.0),
          child: BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, langState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 80.0,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    langState.language == Language.eng ? 'Workout Completed!' : 'Тренировка завершена!',
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    langState.language == Language.eng ? 'Congratulations on completing your workout!' : 'Поздравляем с завершением тренировки!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text( langState.language == Language.eng ? 'Close' : 'Закрыть'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
