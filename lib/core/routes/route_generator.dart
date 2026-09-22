import 'package:chatapp_firebase/features/auth/screens/login_screen.dart';
import 'package:chatapp_firebase/features/auth/screens/onboarding_screen.dart';
import 'package:chatapp_firebase/features/auth/screens/signup_screen.dart';
import 'package:chatapp_firebase/features/auth/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case AppRoutes.authHomeScreen:
        return MaterialPageRoute(builder: (context) => OnboardingScreen());

      case AppRoutes.loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());

      case AppRoutes.signUpScreen:
        return MaterialPageRoute(builder: (context) => SignupScreen());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
