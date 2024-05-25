import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EtaElement extends StatelessWidget {
  const EtaElement({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Text(
                    '2 min',
                    style: TextStyle(
                      fontFamily: 'UberMoveBold',
                      fontSize: 18,
                    ),
                  ),
                  Transform.rotate(
                    angle: 45 * 3.141592653589793 / 180,
                    child: Lottie.network(
                        'https://lottie.host/1e2cd4a1-120e-4f95-8b15-2257bf2e9a1b/j8iPCwLDUL.json',
                        height: 20,
                        width: 20),
                  )
                ],
              ),
              const Text(
                "On-time",
                style: TextStyle(
                    fontFamily: 'UberMoveMedium',
                    fontSize: 16,
                    color: Colors.green),
              )
            ],
          ),
        ),
      ),
    );
  }
}
