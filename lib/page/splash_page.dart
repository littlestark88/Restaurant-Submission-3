import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_apps_local/page/bottom_page.dart';

import 'home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 7),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomPage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Lottie.asset('assets/delivery.json'),
    ));
  }
}
