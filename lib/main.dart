import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/routes/route_generator.dart';
import 'package:chatapp_firebase/features/auth_module/data/data_providers/firebase_auth_provider.dart';
import 'package:chatapp_firebase/features/auth_module/data/repositories/auth_repository.dart';
import 'package:chatapp_firebase/features/auth_module/onboarding/screens/onboarding_screen.dart';
import 'package:chatapp_firebase/features/auth_module/splash/screens/splash_screen.dart';
import 'package:chatapp_firebase/features/tab_bar/screens/tab_bar_base_screen.dart';
import 'package:chatapp_firebase/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'features/tab_bar/cubit/tab_bar_index_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authProvider = FirebaseAuthProvider();
  final authRepository = AuthRepository(provider: authProvider);

  await GoogleSignIn.instance.initialize(
    clientId: "313287695886-58coubkl3he33vaqk59f2umo3ftpjeum.apps.googleusercontent.com",
  );

  runApp(
    RepositoryProvider<AuthRepository>.value(
      value: authRepository,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        title: 'Chat App',
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SplashScreen();
            }
            if (snapshot.hasData && snapshot.data != null) {
              final user = snapshot.data!;

              user.reload().catchError((error) async {
                await FirebaseAuth.instance.signOut();
              });

              return BlocProvider<TabBarIndexCubit>(
                create: (context) => TabBarIndexCubit(),
                child: const TabBarBaseScreen(),
              );
            }
            return OnboardingScreen();
          },
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          dividerTheme: DividerThemeData(
            color: AppColors.dividerColor,
            thickness: 1,
          ),
          appBarTheme: AppBarTheme(surfaceTintColor: Colors.transparent),
          splashColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
      ),
    );
  }
}
