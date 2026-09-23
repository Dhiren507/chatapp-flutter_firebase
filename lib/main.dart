import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/routes/app_routes.dart';
import 'package:chatapp_firebase/core/routes/route_generator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      initialRoute: AppRoutes.mainScreen,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        dividerTheme: DividerThemeData(
          color: AppColors.dividerColor,
          thickness: 1
        ),
        appBarTheme: AppBarTheme(
          surfaceTintColor: Colors.transparent,
        ),
        splashColor: Colors.transparent,
        splashFactory:NoSplash.splashFactory
      ),
    );
  }
}

