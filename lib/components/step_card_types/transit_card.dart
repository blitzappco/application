import 'package:application/models/route.dart';
import 'package:flutter/material.dart';

class TransitCard extends StatelessWidget {
  final TransitDetails? transitDetails;
  const TransitCard({required this.transitDetails, super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
        crossAxisAlignment: CrossAxisAlignment.center, children: []);
  }
}
