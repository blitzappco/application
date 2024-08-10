import 'package:blitz/bifrost/core/models/route.dart';
import 'package:flutter/material.dart';

import '../components/shorthand.dart';
import 'package:blitz/bifrost/core/models/route.dart' as r;

List<Widget> processShorthands(List<r.Step> steps) {
  List<Widget> result = [];
  for (int i = 0; i < steps.length; i++) {
    final step = steps[i];
    result.add(Shorthand(
      duration: step.duration.text,
      transit: step.travelMode == "TRANSIT",
      line: step.transitDetails?.line ?? Line.fromEmpty(),
    ));
    // Add an Icon between each Shorthand except for the last one
    if (i < steps.length - 1) {
      result.add(const Icon(Icons.arrow_right_rounded));
    }
  }
  return result;
}
