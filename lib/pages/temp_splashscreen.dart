import 'dart:async';
import 'package:application/pages/train_ticket/buy_train_ticket.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'homescreen.dart';
import '../pages/onboarding/onboarding.dart';

import '../providers/account_provider.dart';

import '../utils/vars.dart';

class TempSplashscreen extends StatefulWidget {
  const TempSplashscreen({super.key});

  @override
  State<TempSplashscreen> createState() => _TempSplashscreenState();
}

class _TempSplashscreenState extends State<TempSplashscreen> {
  bool _showImage = true;

  Future<void> requestLocationPermissions() async {
    await Permission.location.request();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: _showImage
              ? Image.asset(
                  'assets/images/logo.png',
                  height: 100,
                )
              : const CircularProgressIndicator(
                  color: blitzPurple,
                ),
        ),
      ),
    );
  }
}
