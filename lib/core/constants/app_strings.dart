import 'package:chatapp_firebase/core/constants/app_assets.dart';

class AppStrings {
  static const chatboxText = 'Chatbox';
  static const connectFriendsText = 'Connect friends ';
  static const easilyText = 'easily';
  static const andIconText = ' & ';
  static const quicklyText = 'quickly';
  static const authHomeScreenSubHeading =
      'Our chat app is the perfect way to stay connected with friends and family.';

  static const String orText = 'OR';
  static const String signUpWithEmailText = 'Sign up with  mail';

  static const String existingAccountTxt = 'Existing Account?';
  static const String logInText = 'Log in';

  static const String loginToChatBoxText = 'Log in to Chatbox';
  static const String loginSubheadingText =
      'Welcome back! Sign in using your social account or email to continue us';

  static const String yourEmailLabelText = 'Your email';
  static const String passwordText = 'Password';
  static const String confirmPasswordText = 'Confirm password';
  static const String forgotPasswordText = 'Forgot Password?';

  static const String signupwithEmail = 'Sign up with Email';
  static const String signupSubheadingText =
      'Get chatting with friends and family today by signing up for our chat app!';
  static const String yourNameText = 'Your name';
  static const String yourEmailText = 'Your email';

  static const String createAnAccountText = 'Create an account';

  static const String tabBarLabelOne = 'Message';
  static const String tabBarLabelTwo = 'Calls';
  static const String tabBarLabelThree = 'Contacts';
  static const String tabBarLabelFour = 'Settings';


  static const List<Map<String, dynamic>> settingsOptions = [
    {
      'leadingIcon': AppAssets.keyIcon,
      'optionText': 'Account',
      'subtitle' : 'Privacy, security, change number',
      'navigateTo': ''
    },
    {
    'leadingIcon':AppAssets.messageIcon,
    'optionText': 'Chat',
    'subtitle' : 'Chat history,theme,wallpapers',
      'navigateTo': ''
    },
    {
      'leadingIcon':AppAssets.notificationIcon,
      'optionText': 'Notifications',
      'subtitle' : 'Messages, group and others',
      'navigateTo': ''
    },
    {
      'leadingIcon': AppAssets.helpIcon,
      'optionText': 'Help ',
      'subtitle' : 'Help center,contact us, privacy policy',
      'navigateTo': '',
    },
    {
      'leadingIcon':AppAssets.dataIcon,
      'optionText': 'Storage and data',
      'subtitle' : 'Network usage, storage usage',
      'navigateTo': '',
    },
    {
      'leadingIcon':AppAssets.userGroupIcon,
      'optionText': 'Invite a friend',
      'subtitle' : '',
      'navigateTo': '',
    },
  ];
}
