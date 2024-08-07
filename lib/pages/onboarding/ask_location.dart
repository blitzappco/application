import 'dart:async';

import 'package:blitz/pages/homescreen.dart';
import 'package:blitz/utils/get_location.dart';
import 'package:blitz/utils/vars.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AskLocation extends StatefulWidget {
  const AskLocation({super.key});

  @override
  State<AskLocation> createState() => _AskLocationState();
}

class _AskLocationState extends State<AskLocation> {
  bool _showTick = false;

  Future<void> _handlePermission() async {
    setState(() {
      _showTick = false; // Hide tick animation initially
    });

    Position? position = await getCurrentLocation();
    if (position != null) {
      setState(() {
        _showTick = true;
      });
      // Show the Lottie animation for a short period
      Timer(const Duration(milliseconds: 500), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Homescreen()));
      });
    } else {
      // Show a message or handle permission denial
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Permisiunea nu a fost acordata"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                        child:
                            Image.asset("assets/images/logo.png", height: 75)),
                  ),
                ],
              ),
              const Column(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Location Icon
                        Icon(
                          CupertinoIcons.location_fill,
                          size: 50,
                        ),
                        // Sparkles Icon to the top-left
                        Positioned(
                          top: 15, // Adjust based on how high you want the icon
                          left:
                              15, // Adjust based on how far left you want the icon
                          child: RadiantGradientMask(
                            child: Icon(
                              CupertinoIcons.sparkles,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        // Sparkles Icon to the bottom-right
                        Positioned(
                          bottom:
                              15, // Adjust based on how far down you want the icon
                          right:
                              15, // Adjust based on how far right you want the icon
                          child: RadiantGradientMask(
                            child: Icon(
                              CupertinoIcons.sparkles,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Permite accesul la locație",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "SFProRounded",
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Astfel, vei putea primi indicații de orientare și vei putea beneficia de toate funcțiile aplicației.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "SFProRounded",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: darkGrey,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    "Ești tot timpul în control",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "SFProRounded",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    "Poți schimba permisiunile oricand în setările dispozitivului tău",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "SFProRounded",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: darkGrey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _handlePermission,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: const Color.fromARGB(255, 110, 11, 231),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _showTick
                                ? Center(
                                    child: Lottie.asset(
                                      'assets/tickw.json',
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.fill,
                                      repeat: false,
                                    ),
                                  )
                                : const Text(
                                    "Permite",
                                    style: TextStyle(
                                      fontFamily: "SFProRounded",
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RadiantGradientMask extends StatelessWidget {
  const RadiantGradientMask({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const RadialGradient(
        center: Alignment.center,
        radius: 0.5,
        colors: [Colors.purple, Colors.blue],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}
