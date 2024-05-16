import 'package:application/maps/geocode.dart';
import 'package:application/maps/predictions.dart';
import 'package:application/maps/routes.dart';
import 'package:flutter/material.dart';

class MapsTest extends StatefulWidget {
  const MapsTest({super.key});

  @override
  State<MapsTest> createState() => _MapsTestState();
}

class _MapsTestState extends State<MapsTest> {
  @override
  void initState() {
    super.initState();
    getRoutes("gara de nord", "universitatea bucuresti");
    getPredictions("politehnica");
    getAddressFromPlace('ChIJQVEtE-oBskARx236lMuu1fU');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
