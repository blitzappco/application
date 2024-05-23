import 'package:flutter/material.dart';

class ActivePass extends StatefulWidget {
  const ActivePass({super.key});

  @override
  State<ActivePass> createState() => _ActivePassState();
}

class _ActivePassState extends State<ActivePass> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/card.png'),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      height: 234,
      width: 400,
    );
  }
}
