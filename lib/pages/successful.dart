import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async'; // Import the async package
import 'package:blitz/utils/vars.dart';

class Successful extends StatefulWidget {
  final String item; // The item bought
  final double amount; // The amount paid

  const Successful({
    super.key,
    required this.item,
    required this.amount,
  });

  @override
  State<Successful> createState() => _SuccessfulState();
}

class _SuccessfulState extends State<Successful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/tce.png'),
                    fit: BoxFit.fitWidth,
                  ),
                  shape: BoxShape.circle,
                ),
                width: 80,
                height: 80,
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Platit',
                        style: TextStyle(
                          fontFamily: "SFProRounded",
                          fontWeight: FontWeight.w700,
                          fontSize: 50,
                          height: 1,
                        ),
                      ),
                      Text(
                        'cu success',
                        style: TextStyle(
                          fontFamily: "SFProRounded",
                          fontWeight: FontWeight.w700,
                          fontSize: 50,
                          height: 1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  FutureBuilder(
                    future: Future.delayed(
                        const Duration(milliseconds: 500)), // Half-second delay
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(
                          height: 50,
                          width: 50,
                        ); // Empty container while waiting
                      } else {
                        return SizedBox(
                          height: 50,
                          width: 50,
                          child: Lottie.asset(
                            'assets/lottie/tick.json', // Your Lottie animation file
                            fit: BoxFit.fill,
                            repeat: false, // Ensure animation plays only once
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Suma platita:',
                        style: TextStyle(
                          fontFamily: "SFProRounded",
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          height: 1,
                          color: darkGrey,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'RON ${widget.amount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontFamily: "SFProRounded",
                          fontWeight: FontWeight.w700,
                          fontSize: 23,
                          height: 1,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Produs:',
                        style: TextStyle(
                          fontFamily: "SFProRounded",
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          height: 1,
                          color: darkGrey,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.item,
                        style: const TextStyle(
                          fontFamily: "SFProRounded",
                          fontWeight: FontWeight.w700,
                          fontSize: 23,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      //Add action to activate ticket
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: const Color.fromARGB(255, 94, 8, 199)),
                      child: const Padding(
                        padding: EdgeInsets.all(13.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Activeaza bilet",
                              style: TextStyle(
                                  fontFamily: "SFProRounded",
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: const Color.fromARGB(255, 79, 79, 79)),
                      child: const Padding(
                        padding: EdgeInsets.all(13.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Inchide pagina",
                              style: TextStyle(
                                  fontFamily: "SFProRounded",
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
