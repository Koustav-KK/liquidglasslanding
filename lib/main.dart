import 'package:flutter/material.dart';
import 'package:liquid_glass_landing_page/landing_page_mobile.dart';

// The main function is the entry point of the Flutter app
void main() async {
  // Ensures Flutter is ready before running certain tasks
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase for backend services (e.g., Firestore for contact forms
  // Start the app with the MyApp widget
  runApp(const MyApp());
}

// MyApp is the main widget that sets up the app's structure
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Listens to isDarkMode from LandingPageMobile to switch themes
    return ValueListenableBuilder<bool>(
      valueListenable: LandingPageMobile.isDarkMode,
      builder: (context, isDark, child) {
        // MaterialApp defines the app's theme, title, and home page
        return MaterialApp(
          title: 'Koustav Karmakar Portfolio', // App title
          debugShowCheckedModeBanner: false, // Hides debug banner
          // Light theme configuration
          theme: ThemeData(
            primarySwatch: Colors.teal, // Main color for the app
            scaffoldBackgroundColor:
                Colors.transparent, // Transparent background
            textTheme: const TextTheme(
              bodyMedium: TextStyle(
                color: Colors.black87,
              ), // Default text color
            ),
            brightness: Brightness.light, // Light mode
            colorScheme: ColorScheme.light(
              primary: Colors.teal, // Vibrant teal for buttons, etc.
              secondary: Colors.lightBlue, // Subtle blue for accents
              background: Colors.grey[50]!, // Soft off-white background
              onBackground: Colors.black87, // Dark gray text/icons
            ),
            canvasColor: Colors.grey[50]!, // Matches background
          ),
          // Dark theme configuration
          darkTheme: ThemeData(
            primarySwatch: Colors.teal,
            scaffoldBackgroundColor: Colors.transparent,
            textTheme: const TextTheme(
              bodyMedium: TextStyle(
                color: Colors.white70,
              ), // Light text for dark mode
            ),
            brightness: Brightness.dark, // Dark mode
            colorScheme: ColorScheme.dark(
              primary: Colors.tealAccent, // Bright teal for buttons
              secondary: Colors.blue, // Muted blue for accents
              background: Colors.grey[900]!, // Deep charcoal background
              onBackground: Colors.white70, // Light gray text/icons
            ),
            canvasColor: Colors.grey[900]!, // Matches background
          ),
          // Switch between light and dark theme based on isDarkMode
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          home: const LandingPageMobile(), // The main screen of the app
        );
      },
    );
  }
}
