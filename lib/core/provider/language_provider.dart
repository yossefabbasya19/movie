import 'package:flutter/cupertino.dart';
import 'package:movies/core/shared_pref/shared_pref.dart';

class LanguageProvider extends ChangeNotifier{
  String currentLanguage = SharedPref().getLanguage;
  void switchBetweenLanguage(String language){
    if(currentLanguage == language)return;
    currentLanguage = language;
    SharedPref().saveLanguage(language);
    notifyListeners();
  }
}