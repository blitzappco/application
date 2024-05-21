import 'package:flutter/material.dart';

class AnimatedText extends StatefulWidget {
  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInFadeOut;
  int _textIndex = 0;
  final List<String> _texts = [
    "Tap to validate",
    "Hold your phone near the reader"
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeInFadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _textIndex = (_textIndex + 1) % _texts.length;
          });
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeInFadeOut,
      child: Text(
        _texts[_textIndex],
        style: TextStyle(
          fontSize: 20,
          fontFamily: "UberMoveMedium",
          color: Colors
              .black, // Ensure the text color is visible against the background
        ),
      ),
    );
  }
}
