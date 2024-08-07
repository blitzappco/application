import 'dart:async';

import 'package:blitz/components/alert_box.dart';
import 'package:blitz/pages/homescreen.dart';
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

locationDisabled(BuildContext context) {
  AlertBox.show(
    context,
    title: "Servicii de localizare dezactivate",
    content: "Te rugam sa activezi serviciile de localizare.",
    accept: "Permite",
    decline: "Refuza",
    acceptColor: Colors.blue,
    acceptCallback: () async {
      Geolocator.openLocationSettings();
      Navigator.pop(context);
    },
    declineCallback: () async {
      Navigator.pop(context);
    },
  );
}

permissionDenied(BuildContext context) {
  AlertBox.show(
    context,
    title: "Permisiunea nu a fost acordata",
    content:
        "Te rugam sa accepti permisiunile, pentru a putea folosi aplicatia.",
    accept: "Permite",
    decline: "Refuza",
    acceptColor: Colors.blue,
    acceptCallback: () async {
      Geolocator.openAppSettings();
      Navigator.pop(context);
    },
    declineCallback: () async {
      Navigator.pop(context);
    },
  );
}

permissionDeniedForever(BuildContext context) {
  AlertBox.show(
    context,
    title: "Permisiunea este dezactivata permanent",
    content: "Te rugam sa activezi permisiunile din setarile aplicatiei.",
    accept: "Permite",
    decline: "Refuza",
    acceptColor: Colors.blue,
    acceptCallback: () async {
      Geolocator.openAppSettings();
      Navigator.pop(context);
    },
    declineCallback: () async {
      Navigator.pop(context);
    },
  );
}

class _AskLocationState extends State<AskLocation> {
  bool _showTick = false;
  var permissionState = '';

  Future<void> _handlePermission() async {
    setState(() {
      _showTick = false;
    });

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    //Need to only make an alert box with an aknowledge button. this checks for the location settings turned off systemwide
    if (!serviceEnabled) {
      permissionState = "locationDisabled";
      return;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        permissionState = "permissionDenied";
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      permissionState = "permissionDeniedForever";
      return;
    }

    // If we can preload the map this will help us
    // Position position = await Geolocator.getCurrentPosition();

    setState(() {
      _showTick = true;
    });

    Timer(const Duration(milliseconds: 500), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Homescreen()),
      );
    });
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
                      child: Image.asset("assets/images/logo.png", height: 65),
                    ),
                  ),
                  const SizedBox(),
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
                        Icon(
                          CupertinoIcons.location_fill,
                          size: 50,
                        ),
                        Positioned(
                          top: 15,
                          left: 15,
                          child: RadiantGradientMask(
                            child: Icon(
                              CupertinoIcons.sparkles,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 15,
                          right: 15,
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
                    onTap: () {
                      _handlePermission();
                      switch (permissionState) {
                        case "locationDisabled":
                          locationDisabled(context);
                        case "permissionDenied":
                          permissionDenied(context);
                        case "permissionDeniedForever":
                          permissionDeniedForever(context);
                      }
                    },
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
