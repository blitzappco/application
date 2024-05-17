import 'package:application/maps/predictions.dart';
import 'package:application/maps/routes.dart';
import 'package:application/utils/steps.dart';
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
    processSteps();
  }

  void processSteps() async {
    final routes = await getRoutes("gara de nord", "universitatea bucuresti");
    final place = (await getPredictions("universitatea bucuresti"))[0];
    var stepCards = getSteps(
      routes[0].leg.steps,
      place,
    );
    print(stepCards.map((stepCard) => stepCard.type));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
