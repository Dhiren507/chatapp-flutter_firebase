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

  // ── Chat List Screen ──────────────────────────────────────────────────────
  static const String chatListScreenTitle = 'Home';
  static const String myStatusText = 'My status';

  // ── Chat Detail Screen ────────────────────────────────────────────────────
  static const String chatMessageHintText = 'Type your message here...';
  static const String shareContentTitle = 'Share Content';
  static const String attachmentCameraText = 'Camera';
  static const String attachmentDocumentText = 'Document';
  static const String attachmentDocumentSubtitle = 'Share your files';
  static const String attachmentPollText = 'Create a poll';
  static const String attachmentPollSubtitle = 'Create a poll for any query';
  static const String attachmentMediaText = 'Media';
  static const String attachmentMediaSubtitle = 'Share photos and videos';
  static const String attachmentContactText = 'Contact';
  static const String attachmentContactSubtitle = 'Share your Contacts';
  static const String attachmentLocationText = 'Location';
  static const String attachmentLocationSubtitle = 'Share your location';

  // ── Call List Screen ──────────────────────────────────────────────────────
  static const String callsScreenTitle = 'Calls';
  static const String callsRecentSectionTitle = 'Recent';

  // ── Search Screen ─────────────────────────────────────────────────────────
  static const String searchScreenTitle = 'Search';
  static const String searchHintText = 'Search....';
  static const String searchPeopleSectionTitle = 'People';

  // ── Create Group Screen ───────────────────────────────────────────────────
  static const String createGroupScreenTitle = 'Create Group';
  static const String createGroupDescriptionLabel = 'Group Description';
  static const String createGroupTitleHintText = 'Enter your group title in here.....';
  static const String createGroupAdminLabel = 'Group Admin';
  static const String createGroupAdminRoleText = 'Group Admin';
  static const String createGroupInvitedMembersLabel = 'Invited Members';
  static const String createGroupButtonText = 'Create';

  // ── Settings Screen ───────────────────────────────────────────────────────
  static const String settingsScreenTitle = 'Settings';

  // ── Profile Screen ────────────────────────────────────────────────────────
  static const String profileMediaSharedText = 'Media Shared';
  static const String profileViewAllText = 'View All';
}
