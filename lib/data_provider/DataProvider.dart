import 'package:shared_preferences/shared_preferences.dart';
import 'package:workouts_at_home/utils/enums.dart';

class DataProvider {
  SharedPreferences? _prefs;
  DataProvider() {
    _init();
  }

  Future<void> _init() async {
    if (_prefs != null) return;
    _prefs = await SharedPreferences.getInstance();
  }

  void setLanguage(Language lang) async {
    if (_prefs == null) await _init();
    _prefs!.setString('Language', lang.name);
  }

  Future<Language> getLanguage() async {
    if (_prefs == null) await _init();
    final language = _prefs!.getString('Language');
    if (language == null){
      setLanguage(Language.eng);
      return Language.eng;
    }
    return Language.values.where((lang) => lang.name == language).first;
  }

  void setLevel(TrainingLevel level) async {
    if (_prefs == null) await _init();
    _prefs!.setString('Level', level.name);
  }

  Future<TrainingLevel> getLevel() async {
    if (_prefs == null) await _init();
    final level = _prefs!.getString('Level');
    if (level == null){
      return TrainingLevel.none;
    }
    return TrainingLevel.values.where((lvl) => lvl.name == level).first;
  }

  void setRestTime(int time) async {
    if (_prefs == null) await _init();
    _prefs!.setInt('RestTime', time);
  }

  Future<int> getRestTime() async {
    if (_prefs == null) await _init();
    final time = _prefs!.getInt('RestTime');
    if (time == null){
      setRestTime(30);
      return 30;
    }
    return time;
  }

  void setPrepareTime(int time) async {
    if (_prefs == null) await _init();
    _prefs!.setInt('PrepareTime', time);
  }

  Future<int> getPrepareTime() async {
    if (_prefs == null) await _init();
    final time = _prefs!.getInt('PrepareTime');
    if (time == null){
      setPrepareTime(30);
      return 30;
    }
    return time;
  }

  Future<void> setCompleted() async {
    if (_prefs == null) await _init();
    DateTime firstTime= await getFirstTime();
    final dayNo = (DateTime.now().difference(firstTime).inDays + 1).toString();
    await _prefs!.setBool(dayNo, true);
  }

  Future<bool> getDayData(int dayNo) async {
    if (_prefs == null) await _init();
    return _prefs!.getBool(dayNo.toString()) ?? false;
  }


  Future<DateTime> getFirstTime() async {
    if (_prefs == null) await _init();
    int? time = _prefs!.getInt("firstTime");
    
    if (time == null) {
      final now = DateTime.now();
      await _prefs!.setInt("firstTime", now.millisecondsSinceEpoch);
      return now;
    }
    return DateTime.fromMillisecondsSinceEpoch(time);
  }

  void setAge(int age) async {
    if (_prefs == null) await _init();
    _prefs!.setInt('Age', age);
  }

  Future<int> getAge() async {
    if (_prefs == null) await _init();
    final age = _prefs!.getInt('Age');
    if (age == null){
      setAge(0);
      return 0;
    }
    return age;
  }

  void setWeight(int weight) async {
    if (_prefs == null) await _init();
    _prefs!.setInt('Weight', weight);
  }

  Future<int> getWeight() async {
    if (_prefs == null) await _init();
    final weight = _prefs!.getInt('Weight');
    if (weight == null){
      setWeight(0);
      return 0;
    }
    return weight;
  }

  setAppUrl(String url) async {
    if (_prefs == null) await _init();
    _prefs!.setString('AppUrl', url);
  }
  getAppUrl() async {
    if (_prefs == null) await _init();
    final url = _prefs!.getString('AppUrl');
    if (url == null){
      return '';
    }
    return url;
  }
}