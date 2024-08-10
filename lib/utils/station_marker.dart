import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';

class StationMarker extends StatelessWidget {
  const StationMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      width: 2000,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            StrokeText(
              text: "Piata Victoriei",
              textStyle: TextStyle(
                  fontFamily: "SFProRounded",
                  fontSize: 50,
                  color: Colors.white.withOpacity(0),
                  fontWeight: FontWeight.w600),
              strokeColor: Colors.white.withOpacity(0),
              strokeWidth: 10,
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 5)),
            ),
            SizedBox(
              width: 20,
            ),
            StrokeText(
              text: "Piata",
              textStyle: TextStyle(
                  fontFamily: "SFProRounded",
                  fontSize: 50,
                  color: Color.fromARGB(255, 33, 33, 33),
                  fontWeight: FontWeight.w600),
              strokeColor: Colors.white,
              strokeWidth: 10,
            ),
          ],
        ),
      ),
    );
  }
}
