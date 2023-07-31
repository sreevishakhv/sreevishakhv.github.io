import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String text;
  final bool isAnimate;
  const Loading({super.key, required this.text, this.isAnimate = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 20.0),
          isAnimate
              ? AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      text,
                      textStyle: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                      ),
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  totalRepeatCount: 1,
                  isRepeatingAnimation: false,
                )
              : Text(
                  text,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
        ],
      )),
    );
  }
}
