import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:liquid_glass_landing_page/components.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingPageMobile extends StatefulWidget {
  const LandingPageMobile({super.key});

  static final ValueNotifier<bool> isDarkMode = ValueNotifier<bool>(false);

  @override
  State<LandingPageMobile> createState() => _LandingPageMobileState();
}

class _LandingPageMobileState extends State<LandingPageMobile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true); // Continuous motion for cards
    print('LandingPageMobile initialized');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleTheme() {
    LandingPageMobile.isDarkMode.value = !LandingPageMobile.isDarkMode.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(
          size: 30.0,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: ValueListenableBuilder<bool>(
              valueListenable: LandingPageMobile.isDarkMode,
              builder: (context, isDark, child) {
                return GestureDetector(
                  onTap: _toggleTheme,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
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
      endDrawer: const DrawerMobile(),
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
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: ListView(
            children: [
              // Profile Avatar
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
                      child: DefaultTextStyle(
                        style: GoogleFonts.openSans(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 25.0),
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
                              child: DefaultTextStyle(
                                style: GoogleFonts.openSans(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                                child: SansBold("Hello I'm", 15.0),
                              ),
                            ),
                            DefaultTextStyle(
                              style: GoogleFonts.openSans(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onBackground,
                                fontWeight: FontWeight.bold,
                              ),
                              child: SansBold("Koustav Karmakar", 40.0),
                            ),
                            Sans("B.Tech Student", 20.0),
                            const SizedBox(height: 15.0),
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
                      child: DefaultTextStyle(
                        style: GoogleFonts.openSans(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DefaultTextStyle(
                              style: GoogleFonts.openSans(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onBackground,
                                fontWeight: FontWeight.bold,
                              ),
                              child: SansBold("About Me", 35.0),
                            ),
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
              ),
              const SizedBox(height: 60.0),
              // What I Do Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: DefaultTextStyle(
                  style: GoogleFonts.openSans(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DefaultTextStyle(
                        style: GoogleFonts.openSans(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.bold,
                        ),
                        child: SansBold("What I Do?", 35.0),
                      ),
                      const SizedBox(height: 20.0),
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
                      // Contact Section
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
