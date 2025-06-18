abstract class ValidationRules {
  static String? titleValidation(String? titleInput) {
    if (titleInput!.isEmpty) {
      return "Plz , Enter Title";
    }
    return null;
  }
  static String? phoneValidation(String ?value) {
    if(value!.isNotEmpty){
      if (!((value.substring(0, 3) == '010') ||
          (value.substring(0, 3) == '011') ||
          (value.substring(0, 3) == '012') ||
          (value.substring(0, 3) == '015')) ||
          !(value.length == 11)) {
        return "invalid number";
      }
    }else{
      return "required";
    }
    return null;
  }
  static String? descriptionValidation(String? descriptionInput) {
    if (descriptionInput!.isEmpty) {
      return "Plz , Enter Title";
    }
    if (descriptionInput.length <= 8) {
      return "plz, enter description length more than 8";
    }
    return null;
  }
 static String? emailValidate(String? value) {
    if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(value!)) {
      print("not correct Email");
      return "plz, enter correct Email";
    }
    return null;
  }
  static String? passwordValidate(String? value) {
    if (!RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    ).hasMatch(value!)) {
      print("not correct password");
      return "plz, enter Strong password";
    }
    return null;
  }
}
