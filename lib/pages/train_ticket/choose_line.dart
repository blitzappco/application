import 'package:application/components/active_train_ticket.dart';
import 'package:application/utils/vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseLinePage extends StatefulWidget {
  const ChooseLinePage({super.key});

  @override
  State<ChooseLinePage> createState() => _ChooseLinePageState();
}

class _ChooseLinePageState extends State<ChooseLinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: lightGrey),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Icon(
                              Icons.close,
                              color: darkGrey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Available routes",
                    style: TextStyle(fontFamily: "UberMoveBold", fontSize: 32),
                  ),
                  Text(
                    "Select an option by pressing the desired route",
                    style:
                        TextStyle(fontFamily: "UberMoveMedium", fontSize: 16),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ActiveTrainTicket(),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: lightGrey,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ActiveTrainTicket(),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: lightGrey,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ActiveTrainTicket(),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: lightGrey,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ActiveTrainTicket()
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Continue",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: "UberMoveMedium"),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
