import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:liquid_glass_landing_page/landing_page_mobile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print("Firebase initialization error: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: LandingPageMobile.isDarkMode,
      builder: (context, isDark, child) {
        return MaterialApp(
          title: 'Koustav Karmakar Portfolio',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.teal,
            scaffoldBackgroundColor: Colors.transparent,
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Colors.black87),
            ),
            brightness: Brightness.light,
            colorScheme: ColorScheme.light(
              primary: Colors.teal, // Vibrant teal
              secondary: Colors.lightBlue!, // Subtle purple
              background: Colors.grey[50]!, // Soft off-white
              onBackground: Colors.black87, // Dark gray
            ),
            canvasColor: Colors.grey[50]!, // Matches background
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.teal,
            scaffoldBackgroundColor: Colors.transparent,
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Colors.white70),
            ),
            brightness: Brightness.dark,
            colorScheme: ColorScheme.dark(
              primary: Colors.tealAccent, // Bright teal
              secondary: Colors.blue, // Muted purple
              background: Colors.grey[900]!, // Deep charcoal
              onBackground: Colors.white70, // Light gray
            ),
            canvasColor: Colors.grey[900]!, // Matches background
          ),
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          home: const LandingPageMobile(),
        );
      },
    );
  }
}
