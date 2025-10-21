import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app_router.dart';
import 'config/theme.dart';
import 'firebase_options.dart'; // Ensure this file exists in the 'lib' directory.

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const SCDApp());
}

class SCDApp extends StatelessWidget {
  const SCDApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Shark City Drum & Dance Corps',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark, // Focus on dark theme as per spec
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
