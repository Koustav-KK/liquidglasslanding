import 'dart:ui'; // Needed for ImageFilter in BackdropFilter
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Note: TextEditingControllers for ContactFormMobile and ContactFormWeb are not used in this file
// but are likely used in contact form widgets elsewhere. They manage text input fields.
// Example: final TextEditingController _firstNameController = TextEditingController();

// Sans widget for regular text with OpenSans font
Widget Sans(String text, double size) {
  return Text(
    text,
    style: GoogleFonts.openSans(
      fontSize: size,
    ), // Uses OpenSans font with given size
  );
}

// SansBold widget for bold text with OpenSans font
Widget SansBold(String text, double size) {
  return Text(
    text,
    style: GoogleFonts.openSans(
      fontSize: size,
      fontWeight: FontWeight.bold, // Makes text bold
    ),
  );
}

// Glassmorphism container for skill chips (e.g., "Flutter", "Firebase")
class GlassContainer extends StatelessWidget {
  final String text;

  const GlassContainer(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0), // Rounded corners
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5.0,
          sigmaY: 5.0,
        ), // Blur for glass effect
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.background.withOpacity(0.15), // Semi-transparent
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.onBackground.withOpacity(0.2),
            ),
          ),
          child: Text(
            text,
            style: GoogleFonts.openSans(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 14.0,
            ),
          ),
        ),
      ),
    );
  }
}

// Animated card with glassmorphism and sliding motion
class AnimatedCard extends StatefulWidget {
  final String imagePath; // Path to the image (e.g., "assets/app.png")
  final String text; // Text to display (e.g., "App Development")
  final BoxFit? fit; // How the image fits in the card
  final double width; // Card width
  final double? height; // Card height (optional)
  final bool reverse; // Whether to reverse the animation direction
  final AnimationController? animationController; // Controls animation

  const AnimatedCard({
    super.key,
    required this.imagePath,
    required this.text,
    this.fit,
    this.width = 300.0,
    this.height,
    this.reverse = false,
    this.animationController,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _localController; // Manages animation timing
  late Animation<Offset> _slideAnimation; // Defines sliding motion

  @override
  void initState() {
    super.initState();
    // Use provided controller or create a new one
    _localController =
        widget.animationController ??
              AnimationController(
                duration: const Duration(
                  seconds: 4,
                ), // Animation lasts 4 seconds
                vsync: this, // Syncs animation with screen refresh
              )
          ..repeat(reverse: true); // Loops animation back and forth
    // Define sliding motion from left to right or vice versa
    _slideAnimation =
        Tween<Offset>(
          begin: widget.reverse ? const Offset(-0.2, 0) : const Offset(0.2, 0),
          end: widget.reverse ? const Offset(0.2, 0) : const Offset(-0.2, 0),
        ).animate(
          CurvedAnimation(
            parent: _localController,
            curve: Curves.easeInOut,
          ), // Smooth motion
        );
  }

  @override
  void dispose() {
    // Clean up controller only if it was created locally
    if (widget.animationController == null) {
      _localController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _localController,
      builder: (context, child) {
        // Slide the card based on animation
        return Transform.translate(
          offset: _slideAnimation.value * 50, // Controls slide distance
          child: child,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ), // Glassmorphism blur
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background.withOpacity(0.15),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Display image from assets
                Image.asset(
                  widget.imagePath,
                  fit: widget.fit ?? BoxFit.cover,
                  width: widget.width,
                  height: widget.height != null ? widget.height! - 50 : null,
                ),
                const SizedBox(height: 10.0),
                SansBold(widget.text, 18.0), // Bold text below image
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Drawer for mobile navigation menu
class DrawerMobile extends StatelessWidget {
  const DrawerMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(
        context,
      ).colorScheme.background.withOpacity(0.15),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5.0,
          sigmaY: 5.0,
        ), // Glassmorphism effect
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.onBackground.withOpacity(0.2),
            ),
          ),
          child: ListView(
            children: [
              // Navigation item for Home
              ListTile(
                title: SansBold("Home", 20.0),
                onTap: () {
                  Navigator.pushNamed(context, '/'); // Go to home page
                },
              ),
              // Navigation item for Work
              ListTile(
                title: SansBold("Work", 20.0),
                onTap: () {
                  Navigator.pushNamed(context, '/work'); // Go to work page
                },
              ),
              // Navigation item for Contact
              ListTile(
                title: SansBold("Contact", 20.0),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/contact',
                  ); // Go to contact page
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
