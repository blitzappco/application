import 'package:application/utils/vars.dart';
import 'package:flutter/material.dart';

String processTypes(List<String> types) {
  for (int i = 0; i < types.length; i++) {
    if (mapPlaceIcons.containsKey(types[i])) {
      return types[i];
    }
  }

  return 'general';
}
