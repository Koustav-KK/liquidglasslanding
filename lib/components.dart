import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

// Global controllers for ContactFormMobile and ContactFormWeb
final TextEditingController _firstNameController = TextEditingController();
final TextEditingController _lastNameController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _messageController = TextEditingController();

// Logger instance
final Logger logger = Logger();

// Sans widget for regular text
Widget Sans(String text, double size) {
  return Text(text, style: GoogleFonts.openSans(fontSize: size));
}

// SansBold widget for bold text
Widget SansBold(String text, double size) {
  return Text(
    text,
    style: GoogleFonts.openSans(fontSize: size, fontWeight: FontWeight.bold),
  );
}

// Glassmorphism container for skill chips as a StatelessWidget
class GlassContainer extends StatelessWidget {
  final String text;

  const GlassContainer(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background.withOpacity(0.15),
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

// Animated card with glassmorphism and continuous motion
class AnimatedCard extends StatefulWidget {
  final String imagePath;
  final String text;
  final BoxFit? fit;
  final double width;
  final double? height;
  final bool reverse;
  final AnimationController? animationController;

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
  late AnimationController _localController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _localController =
        (widget.animationController ??
              AnimationController(
                duration: const Duration(seconds: 4),
                vsync: this,
              ))
          ..repeat(reverse: true); // Continuous motion
    _slideAnimation =
        Tween<Offset>(
          begin: widget.reverse ? const Offset(-0.2, 0) : const Offset(0.2, 0),
          end: widget.reverse ? const Offset(0.2, 0) : const Offset(-0.2, 0),
        ).animate(
          CurvedAnimation(parent: _localController, curve: Curves.easeInOut),
        );
    print('AnimatedCard initialized for ${widget.imagePath}');
  }

  @override
  void dispose() {
    if (widget.animationController == null) {
      _localController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Building AnimatedCard for ${widget.imagePath}');
    return AnimatedBuilder(
      animation: _localController,
      builder: (context, child) {
        return Transform.translate(
          offset: _slideAnimation.value * 50, // Adjust amplitude of motion
          child: child,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
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
                Image.asset(
                  widget.imagePath,
                  fit: widget.fit ?? BoxFit.cover,
                  width: widget.width,
                  height: widget.height != null ? widget.height! - 50 : null,
                ),
                const SizedBox(height: 10.0),
                DefaultTextStyle(
                  style: GoogleFonts.openSans(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
                  child: SansBold(widget.text, 18.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Drawer for mobile
class DrawerMobile extends StatelessWidget {
  const DrawerMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(
        context,
      ).colorScheme.background.withOpacity(0.15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
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
              ListTile(
                title: DefaultTextStyle(
                  style: GoogleFonts.openSans(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
                  child: SansBold("Home", 20.0),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
              ),
              ListTile(
                title: DefaultTextStyle(
                  style: GoogleFonts.openSans(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
                  child: SansBold("Work", 20.0),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/work');
                },
              ),
              ListTile(
                title: DefaultTextStyle(
                  style: GoogleFonts.openSans(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
                  child: SansBold("Contact", 20.0),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/contact');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ... (Rest of the code for DrawersWeb, TabsWebList, AddDataFirestore, DialogError, textForm, ContactFormWeb, ContactFormMobile remains unchanged as they are not included)
