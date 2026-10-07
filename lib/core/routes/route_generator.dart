import 'package:chatapp_firebase/core/data/repositories/contact_repository.dart';
import 'package:chatapp_firebase/features/auth_module/data/repositories/auth_repository.dart';
import 'package:chatapp_firebase/features/auth_module/login/bloc/login_bloc.dart';
import 'package:chatapp_firebase/features/auth_module/onboarding/bloc/onboarding_bloc.dart';
import 'package:chatapp_firebase/features/auth_module/onboarding/screens/onboarding_screen.dart';
import 'package:chatapp_firebase/features/auth_module/splash/screens/splash_screen.dart';
import 'package:chatapp_firebase/features/contacts_module/bloc/contact_list_bloc.dart';
import 'package:chatapp_firebase/features/group_module/create_group/bloc/create_group_bloc.dart';
import 'package:chatapp_firebase/features/group_module/create_group/screens/create_group_screen.dart';
import 'package:chatapp_firebase/features/messages_module/chat_detail/bloc/chat_detail_bloc.dart';
import 'package:chatapp_firebase/features/messages_module/chat_detail/screens/chat_detail_screen.dart';
import 'package:chatapp_firebase/features/messages_module/chat_listing/bloc/chat_list_bloc.dart';
import 'package:chatapp_firebase/features/messages_module/data/repositories/chat_repository.dart';
import 'package:chatapp_firebase/features/profile_module/user_profile_screen.dart';
import 'package:chatapp_firebase/features/search_module/bloc/search_bloc.dart';
import 'package:chatapp_firebase/features/search_module/screens/search_screen.dart';
import 'package:chatapp_firebase/features/settings_module/bloc/setting_bloc.dart';
import 'package:chatapp_firebase/features/status_module/add_status/bloc/status_bloc.dart';
import 'package:chatapp_firebase/features/status_module/add_status/screens/status_preview_screen.dart';
import 'package:chatapp_firebase/features/status_module/data/repositories/status_repository.dart';
import 'package:chatapp_firebase/features/status_module/view_status/bloc/view_status_bloc.dart';
import 'package:chatapp_firebase/features/tab_bar/cubit/tab_bar_index_cubit.dart';
import 'package:chatapp_firebase/features/tab_bar/screens/tab_bar_base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth_module/login/screens/login_screen.dart';
import '../../features/auth_module/signup/bloc/signup_bloc.dart';
import '../../features/auth_module/signup/screens/signup_screen.dart';
import '../../features/status_module/view_status/screens/status_view_screen.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case AppRoutes.onboardingScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<OnboardingBloc>(
            create: (context) => OnboardingBloc(authRepository: context.read<AuthRepository>()),
            child: const OnboardingScreen(),
          ),
        );

      case AppRoutes.loginScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(authRepository: context.read<AuthRepository>()),
            child: const LoginScreen(),
          ),
        );

      case AppRoutes.signUpScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<SignupBloc>(
            create: (context) => SignupBloc(authRepository: context.read<AuthRepository>()),
            child: const SignupScreen(),
          ),
        );

      case AppRoutes.mainScreen:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<TabBarIndexCubit>(create: (context) => TabBarIndexCubit()),
              BlocProvider<ContactListBloc>(
                create: (context) => ContactListBloc(contactRepo: context.read<ContactRepository>()),
              ),
              BlocProvider<ChatListBloc>(
                create: (context) => ChatListBloc(
                  chatRepo: context.read<ChatRepository>(),
                  statusRepo: context.read<StatusRepository>(),
                ),
              ),
              BlocProvider<SettingBloc>(
                create: (context) => SettingBloc(
                  authRepository: context.read<AuthRepository>(),
                ),
              ),
            ],
            child: const TabBarBaseScreen(),
          ),
        );

      case AppRoutes.profileScreen:
        return MaterialPageRoute(builder: (context) => UserProfileScreen());

      case AppRoutes.chatDetailScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ChatDetailBloc>(
            create: (context) => ChatDetailBloc(chatRepo: context.read<ChatRepository>()),
            child: const ChatDetailScreen(),
          ),
          settings: settings,
        );

      case AppRoutes.searchScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<SearchBloc>(
            create: (context) => SearchBloc(
              contactRepo: context.read<ContactRepository>(),
              chatRepo: context.read<ChatRepository>(),
            ),
            child: const SearchScreen(),
          ),
          settings: settings,
        );

      case AppRoutes.crateGroupScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<CreateGroupBloc>(
            create: (context) => CreateGroupBloc(chatRepo: context.read<ChatRepository>()),
            child: const CreateGroupScreen(),
          ),
          settings: settings,
        );

      case AppRoutes.statusPreviewScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<StatusBloc>(
            create: (context) => StatusBloc(
              statusRepo: context.read<StatusRepository>(),
            ),
            child: const StatusPreviewScreen(),
          ),
          settings: settings,
        );

      case AppRoutes.statusViewScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ViewStatusBloc>(
            create: (context) => ViewStatusBloc(
              statusRepo: context.read<StatusRepository>(),
            ),
            child: const StatusViewScreen(),
          ),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
