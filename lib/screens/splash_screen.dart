import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1400));
    Timer(const Duration(milliseconds: 1000),
        () => _animationController!.forward());
    Future.delayed(
      const Duration(seconds: 3, milliseconds: 500),
      () {
        Navigator.pushReplacementNamed(context, '/listItem');
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9FFFC),
      body: Center(
        child: FadeTransition(
          opacity: _animationController!,
          child: Image.asset('assets/images/logo.jpg'),
        ),
      ),
    );
  }
}
