import 'package:flutter/material.dart';
import '../utils/vars.dart';
import './line_shorthand.dart';

class Shorthand extends StatelessWidget {
  final bool isWalk;
  final int time;
  final String lineName;
  final String lineType;
  const Shorthand({
    required this.isWalk,
    required this.time,
    required this.lineName,
    required this.lineType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return isWalk
        ? Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: lightGrey, borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                  child: Row(children: [
                    const Icon(
                      Icons.directions_walk_rounded,
                      color: darkGrey,
                      size: 15,
                    ),
                    Text(
                      '$time mins',
                      style: const TextStyle(fontSize: 13, color: darkGrey),
                    )
                  ]),
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LineShorthand(
                lineName: lineName,
              ),
            ],
          );
  }
}
