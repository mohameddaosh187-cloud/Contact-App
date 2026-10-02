import 'package:contact_app/core/routes/app_routes.dart';
import 'package:contact_app/feature/view/screens/home_screen.dart';
import 'package:contact_app/feature/view/screens/new_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ContactApp());
}

class ContactApp extends StatefulWidget {
  const ContactApp({super.key});

  @override
  State<ContactApp> createState() => _ContactAppState();
}

class _ContactAppState extends State<ContactApp> {
  ThemeMode themeMode = ThemeMode.light;

  void changeTheme() {
    setState(() {
      themeMode = themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      themeMode: themeMode,

      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xff121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff121212),
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),

      initialRoute: AppRoutes.home,

      routes: {
        AppRoutes.home: (context) => HomeScreen(
          onThemeChanged: changeTheme,
          isDark: themeMode == ThemeMode.dark,
        ),
        AppRoutes.newContact: (context) => NewContactScreen(
          onThemeChanged: changeTheme,
          isDark: themeMode == ThemeMode.dark,
        ),
      },
    );
  }
}
