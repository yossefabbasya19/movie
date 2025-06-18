import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._();
  static SharedPref instance = SharedPref._();
  factory SharedPref(){
    return instance;
  }
  late SharedPreferences sharedPreferences;
  init()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }
  get onBoardingIsOpen{
    return sharedPreferences.getBool("onBoardingKey")??false;
  }
   onBoardingIsAlreadyOpen(){
     sharedPreferences.setBool("onBoardingKey",true);
  }
  void saveLanguage(String currentLanguage){
    sharedPreferences.setString("Language",currentLanguage);
  }
 get getLanguage{
    return sharedPreferences.getString("Language")??"en";
 }
}