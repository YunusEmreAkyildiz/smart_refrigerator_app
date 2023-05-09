class AppTexts {
  static const String dontHaveAnAccountText = "Don't have an account?";
  static const String signUpPageAppBarTitle = 'Join FridgeTracker Now!';
  static const String homeScreenAppBarTitle = 'Home';
}

class AppRegExps {
  static RegExp emailRegExp =
      RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+$');
  static RegExp passwordRegExp = RegExp(r'^.{6,}$');
  static RegExp nameRegExp = RegExp(r'^.{3,}$');
}
