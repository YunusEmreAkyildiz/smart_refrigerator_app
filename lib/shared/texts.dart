class AppTexts {
  static const String dontHaveAnAccountText = "Don't have an account?";
  static const String signUpPageAppBarTitle = 'Join FridgeTracker Now!';
  static const String homeScreenAppBarTitle = 'FridgeTracker';
  static const String profileScreenAppBarTitle = 'My Profile';
  static const String getFridgePhoto = 'Show my fridge!';
  static const String homeScreenMainText =
      'We hope you have a great day! Would you like to take a look inside of your fridge?';
  static const String signOutText = 'Sign Out';
  static const String noImageFoundText = 'No image found';
  static const String userAyseOzgurId = 'eTUGRAQU3ZSb9DFZwrilqd82Shi1';
}

class AppRegExps {
  static RegExp emailRegExp =
      RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+$');
  static RegExp passwordRegExp = RegExp(r'^.{6,}$');
  static RegExp nameRegExp = RegExp(r'^.{3,}$');
}

String getWelcomeText(firstName) {
  return 'Hello, $firstName';
}
