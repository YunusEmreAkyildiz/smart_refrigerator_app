class AppTexts {
  static const String dontHaveAnAccountText = "Don't have an account?";
  static const String signUpPageAppBarTitle = 'Join FridgeTracker Now!';
  static const String homeScreenAppBarTitle = 'FridgeTracker';
  static const String profileScreenAppBarTitle = 'My Profile';
  static const String showFridgeButtonText = 'Show my fridge!';
  static const String homeScreenMainText =
      'We hope you have a great day! Would you like to take a look inside of your fridge?';
  static const String signOutText = 'Sign Out';
  static const String noImageFoundText = 'No image found';
  static const String userAyseOzgurId = 'eTUGRAQU3ZSb9DFZwrilqd82Shi1';
  static const String alertDialogSignOutTitle = "Hey,";
  static const String alertDialogSignOutContent =
      "Are you sure you want to sign out?";
  static const String alertDialogSignOutCancelText = "Cancel";
  static const String alertDialogSignOutConfirmedText = "Yes";
  static const String failedToDownloadJson1 =
      'Failed to download the JSON-1 file';
  static const String failedToDownloadJson2 =
      'Failed to download the JSON-2 file';
  static const String noDataAvailable = 'No data available';
  static const String userDocumentNotFound = 'User document not found';
  static const String emptyFridgeMessage = 'Your fridge looks empty :(';
  static const String currentFoodListTitle = "Your fridge's content:";
  static const String foodToAddListTitle = 'Newly added food:';
  static const String foodToRemoveListTitle = 'Recently taken out food:';

  static foodDurationMessage(int minute) {
    switch (minute) {
      case 0:
        return '*The content has not changed for the last minute';
      case 1:
        return '*The content has not changed for $minute minute';
      default:
        return '*The content has not changed for $minute minutes';
    }
  }
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
