import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workouts_at_home/states/LanguageCubit/language_cubit.dart';
import 'package:workouts_at_home/utils/enums.dart';

class InputDialog extends StatefulWidget {
  final String label;
  final String value;
  const InputDialog({super.key, required this.label, required this.value});
  @override
  InputDialogState createState() => InputDialogState();
}

class InputDialogState extends State<InputDialog> {
  late final TextEditingController _valueController;

  @override
  void initState() {
    super.initState();
    _valueController = TextEditingController(text: widget.value);
  }

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width > 300 ? 300 : MediaQuery.of(context).size.width;
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, langState) {
        return AlertDialog(
          title: Text(
            '${langState.language == Language.eng ? 'Enter Your' : 'Введите свой'} ${widget.label}',
            style: TextStyle(fontSize: width*0.07),
          ),
          content: TextField(
            controller: _valueController,
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: width*0.06),
            decoration: InputDecoration(
              hintText: widget.label,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                langState.language == Language.eng ? 'Cancel' : 'Отмена',
                style: TextStyle(fontSize: width*0.06)
              ),
            ),
            TextButton(
              onPressed: () {
                String valueText = _valueController.text.trim();
                if (valueText.isNotEmpty) {
                  int? value = int.tryParse(valueText);
                  if (value != null && value >= 0) {
                    Navigator.pop(context, value); // Pass the value back to the caller
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('${langState.language == Language.eng ? 'Invalid' : 'Недопустимый'} ${widget.label}'),
                          content: Text(langState.language == Language.eng ? 'Please enter a valid value.' : 'Пожалуйста, введите допустимое значение.', style: TextStyle(fontSize: width*0.06)),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                langState.language == Language.eng ? 'Ok' : 'Хорошо',
                                style: TextStyle(fontSize: width*0.06),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              },
              child: Text(langState.language == Language.eng ? 'Ok' : 'Хорошо', style: TextStyle(fontSize: width*0.06)),
            ),
          ],
        );
      },
    );
  }
}
