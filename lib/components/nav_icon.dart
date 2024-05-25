import 'package:flutter/material.dart';

class NavIcon extends StatelessWidget {
  const NavIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(
            Icons.fullscreen_rounded,
            size: 45,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: Transform.rotate(
              angle: 45 * 3.1415926535897932 / 180,
              child: const Icon(
                Icons.navigation_rounded,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
