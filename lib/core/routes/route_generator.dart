import 'package:chatapp_firebase/features/auth_module/login/bloc/login_bloc.dart';
import 'package:chatapp_firebase/features/auth_module/onboarding/screens/onboarding_screen.dart';
import 'package:chatapp_firebase/features/auth_module/splash/screens/splash_screen.dart';
import 'package:chatapp_firebase/features/chat_module/screens/chat_detail_screen.dart';
import 'package:chatapp_firebase/features/group_module/create_group/screens/create_group_screen.dart';
import 'package:chatapp_firebase/features/profile_module/user_profile_screen.dart';
import 'package:chatapp_firebase/features/search/screens/search_screen.dart';
import 'package:chatapp_firebase/features/tab_bar/cubit/tab_bar_index_cubit.dart';
import 'package:chatapp_firebase/features/tab_bar/screens/tab_bar_base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth_module/login/screens/login_screen.dart';
import '../../features/auth_module/signup/bloc/signup_bloc.dart';
import '../../features/auth_module/signup/screens/signup_screen.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case AppRoutes.onboardingScreen:
        return MaterialPageRoute(builder: (context) => OnboardingScreen());

      case AppRoutes.loginScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(),
            child: const LoginScreen(),
          ),
        );

      case AppRoutes.signUpScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<SignupBloc>(
            create: (context) => SignupBloc(),
            child: const SignupScreen(),
          ),
        );

      case AppRoutes.mainScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<TabBarIndexCubit>(
            create: (context) => TabBarIndexCubit(),
            child: const TabBarBaseScreen(),
          ),
        );

      case AppRoutes.profileScreen:
        return MaterialPageRoute(builder: (context) => UserProfileScreen());

      case AppRoutes.chatDetailScreen:
        return MaterialPageRoute(builder: (context) => ChatDetailScreen());

      case AppRoutes.searchScreen:
        return MaterialPageRoute(builder: (context) => SearchScreen());

      case AppRoutes.crateGroupScreen:
        return MaterialPageRoute(builder: (context) => CreateGroupScreen());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
