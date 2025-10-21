import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Let's simplify this to just show the hero image, since the text
    // is already part of the image file.
    return SizedBox(
      height: 380,
      width: double.infinity,
      // By changing the alignment to topCenter, we ensure the top of the
      // image (with the logo) is always visible, even on wide screens
      // where the bottom might be cropped.
      child: Image.asset(
        'assets/hero.png',
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
    );
  }
}
