part of 'language_cubit.dart';

class LanguageState {
  final Language language;
  LanguageState(this.language);
}

final class LanguageInitial extends LanguageState {
  LanguageInitial() : super(Language.eng);
}
