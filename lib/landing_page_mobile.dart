import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_glass_landing_page/components.dart';

// This is the main widget for the mobile landing page of the portfolio
class LandingPageMobile extends StatefulWidget {
  const LandingPageMobile({super.key});

  // A variable to track whether the app is in dark or light mode
  static final ValueNotifier<bool> isDarkMode = ValueNotifier<bool>(false);

  @override
  State<LandingPageMobile> createState() => _LandingPageMobileState();
}

// State class for LandingPageMobile, manages dynamic changes like animations
class _LandingPageMobileState extends State<LandingPageMobile>
    with SingleTickerProviderStateMixin {
  // Animation controller for moving cards back and forth
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Set up the animation controller to run for 4 seconds and loop
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this, // Helps synchronize animations with screen refresh
    )..repeat(reverse: true); // Makes cards move continuously
  }

  @override
  void dispose() {
    // Clean up the animation controller to avoid memory leaks
    _controller.dispose();
    super.dispose();
  }

  // Function to switch between light and dark mode
  void _toggleTheme() {
    LandingPageMobile.isDarkMode.value = !LandingPageMobile.isDarkMode.value;
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold is the basic layout structure for a Flutter screen
    return Scaffold(
      // Makes the body extend behind the AppBar for a transparent effect
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      // AppBar is the top bar with a menu icon and theme toggle button
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0, // No shadow under the AppBar
        iconTheme: IconThemeData(
          size: 30.0,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        actions: [
          // Theme toggle button with padding on the right
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            // Listens to isDarkMode to update the button icon
            child: ValueListenableBuilder<bool>(
              valueListenable: LandingPageMobile.isDarkMode,
              builder: (context, isDark, child) {
                return GestureDetector(
                  onTap: _toggleTheme, // Calls _toggleTheme when tapped
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    // Adds a blur effect for glassmorphism look
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          // Gradient background for the button
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.3),
                              Theme.of(
                                context,
                              ).colorScheme.secondary.withOpacity(0.3),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Theme.of(
                              context,
                            ).colorScheme.onBackground.withOpacity(0.2),
                          ),
                        ),
                        child: Icon(
                          // Shows sun icon in dark mode, moon icon in light mode
                          isDark ? Icons.light_mode : Icons.dark_mode,
                          color: Theme.of(context).colorScheme.onBackground,
                          size: 24.0,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // Drawer for navigation menu, opens from the right
      endDrawer: const DrawerMobile(),
      // Main content with a gradient background
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.background.withOpacity(0.3),
              Theme.of(context).colorScheme.secondary.withOpacity(0.3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        // Adds a blur effect to the entire body
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          // ListView makes the content scrollable
          child: ListView(
            children: [
              // Profile Avatar Section
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(
                          context,
                        ).colorScheme.onBackground.withOpacity(0.2),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).colorScheme.onBackground.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 117.0,
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.background.withOpacity(0.2),
                      child: CircleAvatar(
                        radius: 110.0,
                        backgroundColor: Colors.transparent,
                        backgroundImage: const AssetImage("assets/crop.png"),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50.0),

              // Intro Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.background.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).colorScheme.onBackground.withOpacity(0.2),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).colorScheme.onBackground.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 25.0),
                          // "Hello I'm" label with gradient background
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(
                                    context,
                                  ).colorScheme.primary.withOpacity(0.5),
                                  Theme.of(
                                    context,
                                  ).colorScheme.secondary.withOpacity(0.5),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 20.0,
                            ),
                            child: SansBold("Hello I'm", 15.0),
                          ),
                          SansBold("Koustav Karmakar", 40.0),
                          Sans("B.Tech Student", 20.0),
                          const SizedBox(height: 15.0),
                          // Contact Information
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Wrap(
                                direction: Axis.vertical,
                                spacing: 3.0,
                                children: [
                                  Icon(
                                    Icons.email,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onBackground,
                                  ),
                                  Icon(
                                    Icons.call,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onBackground,
                                  ),
                                  Icon(
                                    Icons.location_pin,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onBackground,
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20.0),
                              Wrap(
                                direction: Axis.vertical,
                                spacing: 9.0,
                                children: [
                                  Sans("koustavscience29@gmail.com", 15.0),
                                  Sans("8617845174", 15.0),
                                  Sans("Kolkata, India", 15.0),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 90.0),

              // About Me Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.background.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).colorScheme.onBackground.withOpacity(0.2),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).colorScheme.onBackground.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SansBold("About Me", 35.0),
                          Sans(
                            "Hello! I'm Koustav Karmakar, a B.Tech Computer Science and Engineering Student",
                            15.0,
                          ),
                          Sans("Flutter Developer", 15.0),
                          Sans(
                            "Mastering App Development on Platforms: Android, iOS, MacOS, Windows",
                            15.0,
                          ),
                          const SizedBox(height: 10.0),
                          // Skills displayed as chips
                          Wrap(
                            spacing: 7.0,
                            runSpacing: 7.0,
                            children: [
                              GlassContainer("Flutter"),
                              GlassContainer("FireBase"),
                              GlassContainer("Android"),
                              GlassContainer("iOS"),
                              GlassContainer("MacOS"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60.0),

              // What I Do Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SansBold("What I Do?", 35.0),
                    const SizedBox(height: 20.0),
                    // Animated cards for showcasing skills
                    AnimatedCard(
                      key: UniqueKey(),
                      imagePath: "assets/app.png",
                      text: "App Development",
                      width: 300.0,
                      animationController: _controller,
                    ),
                    const SizedBox(height: 35.0),
                    AnimatedCard(
                      key: UniqueKey(),
                      imagePath: "assets/webL.png",
                      text: "Web Development",
                      fit: BoxFit.contain,
                      width: 300.0,
                      reverse: true,
                      animationController: _controller,
                    ),
                    const SizedBox(height: 35.0),
                    AnimatedCard(
                      key: UniqueKey(),
                      imagePath: "assets/firebase.png",
                      text: "Backend Development",
                      fit: BoxFit.contain,
                      width: 300.0,
                      animationController: _controller,
                    ),
                    const SizedBox(height: 60.0),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
