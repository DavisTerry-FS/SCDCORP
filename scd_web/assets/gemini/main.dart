import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scd_web/app_router.dart';
import 'package:scd_web/config/theme.dart';
import 'package:scd_web/firebase_options.dart';

void main() async {
  // Ensure that the Flutter binding is initialized before calling Firebase.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the platform-specific options
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
