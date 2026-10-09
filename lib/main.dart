import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_keys.dart';
import 'package:chatapp_firebase/core/routes/route_generator.dart';
import 'package:chatapp_firebase/features/auth_module/data/data_providers/firebase_auth_provider.dart';
import 'package:chatapp_firebase/features/auth_module/data/repositories/auth_repository.dart';
import 'package:chatapp_firebase/features/auth_module/splash/screens/splash_screen.dart';
import 'package:chatapp_firebase/features/contacts_module/data/repositories/contact_repository.dart';
import 'package:chatapp_firebase/features/messages_module/data/repositories/chat_repository.dart';
import 'package:chatapp_firebase/features/status_module/data/repositories/status_repository.dart';
import 'package:chatapp_firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authProvider = AppAuthProvider();
  final authRepository = AuthRepository(provider: authProvider);

  await GoogleSignIn.instance.initialize(clientId: AppKeys.googleAuthClientId);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>.value(value: authRepository),
        RepositoryProvider<ChatRepository>(create: (context) => ChatRepository()),
        RepositoryProvider<ContactRepository>(create: (context) => ContactRepository()),
        RepositoryProvider<StatusRepository>(create: (context) => StatusRepository()),
      ],
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
        home: SplashScreen(),
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          dividerTheme: DividerThemeData(color: AppColors.dividerColor, thickness: 1),
          appBarTheme: AppBarTheme(surfaceTintColor: Colors.transparent),
          splashColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
      ),
    );
  }
}
