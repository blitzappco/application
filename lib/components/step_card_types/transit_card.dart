import 'package:application/models/route.dart';
import 'package:flutter/material.dart';

class TransitCard extends StatelessWidget {
  final TransitDetails? td;
  const TransitCard({required this.td, super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
        crossAxisAlignment: CrossAxisAlignment.center, children: []);
  }
}
