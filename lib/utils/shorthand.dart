import 'package:application/models/route.dart';
import 'package:flutter/material.dart';

import '../components/shorthand.dart';
import '../models/route.dart' as r;

List<Widget> processShorthands(List<r.Step> steps) {
  List<Widget> result = [];
  for (int i = 0; i < steps.length; i++) {
    final step = steps[i];
    result.add(Shorthand(
      duration: step.duration.text,
      transit: step.travelMode == "TRANSIT",
      line: step.transitDetails?.line ?? Line.empty(),
    ));
    result.add(const SizedBox(width: 10));
  }
  return result;
}
