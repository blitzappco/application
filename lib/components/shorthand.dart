import 'package:blitz/models/route.dart';
import 'package:flutter/material.dart';
import '../utils/vars.dart';
import './line_shorthand.dart';

class Shorthand extends StatelessWidget {
  final bool transit;
  final String duration;
  final Line line;
  const Shorthand({
    required this.transit,
    required this.duration,
    required this.line,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return !transit
        ? Container(
            decoration: BoxDecoration(
                color: lightGrey, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisSize:
                    MainAxisSize.min, // Ensure it takes only necessary space
                children: [
                  const Icon(
                    Icons.directions_walk_rounded,
                    color: darkGrey,
                    size: 15,
                  ),
                  Text(
                    duration,
                    style: const TextStyle(fontSize: 13, color: darkGrey),
                  ),
                ],
              ),
            ),
          )
        : Row(
            mainAxisSize:
                MainAxisSize.min, // Ensure it takes only necessary space
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LineShorthand(
                line: line,
              ),
            ],
          );
  }
}
