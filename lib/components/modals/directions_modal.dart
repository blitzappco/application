import 'package:application/components/modals/departures_modal.dart';
import 'package:application/components/modals/profile_modal.dart';
import 'package:application/components/nearby_stations.dart';
import 'package:application/components/place_list.dart';
import 'package:application/components/static_searchbar.dart';
import 'package:application/components/step_card_types/step_card.dart';
import 'package:application/utils/env.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DirectionsModal extends StatelessWidget {
  const DirectionsModal({super.key});

  @override
  Widget build(BuildContext context) {
    final _controller = DraggableScrollableController();
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.9,
      minChildSize: 0.19,
      snap: true,
      snapSizes: [0.19, 0.48, 0.9],
      controller: _controller,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          controller: scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  decoration: BoxDecoration(
                    color: Color(0xFFF8F8F8),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '37 min • Arrival time: 14:32',
                              style: TextStyle(
                                  fontSize: 20, fontFamily: "UberMoveMedium"),
                            ),
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
                        SizedBox(
                          height: 5,
                        ),
                        Divider(),
                        SizedBox(
                          height: 10,
                        ),
                        StepCard(
                          type: 'walk_station',
                          vehicle: 'vehicle',
                          vehicle_dest: 'vehicle_dest',
                          direction: '2',
                          distance: 100,
                          minutes: 8,
                          address: 'address',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(),
                        SizedBox(
                          height: 10,
                        ),
                        StepCard(
                          type: 'go_platform',
                          vehicle: 'M1',
                          vehicle_dest: 'Dristor 2',
                          direction: '2',
                          distance: 100,
                          minutes: 8,
                          address: 'address',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(),
                        SizedBox(
                          height: 10,
                        ),
                        StepCard(
                          type: 'exit_station',
                          vehicle: 'vehicle',
                          vehicle_dest: 'vehicle_dest',
                          direction: 'Splaiul Independentei',
                          distance: 100,
                          minutes: 8,
                          address: 'address',
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
