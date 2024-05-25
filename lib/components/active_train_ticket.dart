import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';

class ActiveTrainTicket extends StatefulWidget {
  final int minutes = 78;
  final String operator = "CFR";
  final String trainNumber = "IR 2458";
  final int delay = 0;
  final String departure = "Bucuresti Nord";
  final String arrival = "Ploiesti Vest";
  final String departureTime = "10:45";
  final String arrivalTime = "11:32";
  const ActiveTrainTicket({
    super.key,
  });

  @override
  State<ActiveTrainTicket> createState() => _ActiveTrainTicketState();
}

class _ActiveTrainTicketState extends State<ActiveTrainTicket> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Column(
          children: [
            Text(
              "1h",
              style: TextStyle(fontFamily: "UberMoveBold", fontSize: 32),
            ),
            Row(
              children: [
                Text(
                  "40 ",
                  style: TextStyle(fontFamily: "UberMoveMedium", fontSize: 12),
                ),
                Text(
                  "MINUTES",
                  style: TextStyle(
                      fontFamily: "UberMoveMedium",
                      fontSize: 12,
                      color: darkGrey),
                ),
              ],
            )
          ],
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.train,
                        size: 15,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "IC 245",
                        style: TextStyle(
                            fontFamily: "UberMoveMedium",
                            fontSize: 14,
                            color: darkGrey),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Departs",
                        style: TextStyle(
                            fontFamily: "UberMoveMedium",
                            fontSize: 14,
                            color: darkGrey),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "On Time",
                        style: TextStyle(
                            fontFamily: "UberMoveMedium",
                            fontSize: 14,
                            color: Colors.green[600]),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Row(
                children: [
                  Text(
                    "Bucuresti Nord ",
                    style: TextStyle(fontFamily: "UberMoveBold", fontSize: 17),
                  ),
                  Text(
                    "to ",
                    style: TextStyle(
                        fontFamily: "UberMoveMedium",
                        fontSize: 17,
                        color: darkGrey),
                  ),
                  Text(
                    "Ploiesti Vest",
                    style: TextStyle(fontFamily: "UberMoveBold", fontSize: 17),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Transform.rotate(
                          angle: -45 * 180,
                          child: Icon(
                            Icons.arrow_circle_right_rounded,
                            color: Colors.green[600],
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "10:30",
                        style: TextStyle(
                            fontFamily: "UberMoveMedium",
                            fontSize: 15,
                            color: Colors.green[600]),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Transform.rotate(
                          angle: 45 * 180,
                          child: Icon(
                            Icons.arrow_circle_right_rounded,
                            color: Colors.green[600],
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "12:50",
                        style: TextStyle(
                            fontFamily: "UberMoveMedium",
                            fontSize: 15,
                            color: Colors.green[600]),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
