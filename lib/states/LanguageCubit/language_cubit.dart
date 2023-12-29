import 'package:bloc/bloc.dart';
import 'package:workouts_at_home/data_provider/DataProvider.dart';
import 'package:workouts_at_home/utils/enums.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final DataProvider dataProvider;
  LanguageCubit(this.dataProvider) : super(LanguageInitial()) {
    getLanguage();
  }

  setLanguage(Language language) {
    dataProvider.setLanguage(language);
    emit(LanguageState(language));
  }

  getLanguage() async {
    emit(LanguageState(await dataProvider.getLanguage()));
  }
}
