import 'package:application/components/nearby_stations.dart';
import 'package:application/components/place_list.dart';
import 'package:application/components/static_searchbar.dart';
import 'package:application/utils/env.dart';
import 'package:flutter/material.dart';

class MainModal extends StatelessWidget {
  const MainModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 0,
        bottom: 0,
        left: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Container(
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
                            'Route',
                            style: TextStyle(
                                fontSize: 32,
                                fontFamily: 'UberMoveBold',
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.wallet,
                                size: 25,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.blue),
                                width: 37,
                                height: 37,
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      StaticSearchbar(),
                      SizedBox(
                        height: 15,
                      ),
                      // Nearby stations
                      Row(
                        children: [
                          Text(
                            "Nearby stations",
                            style: TextStyle(
                                color: darkGrey,
                                fontSize: 14,
                                fontFamily: 'UberMoveMedium'),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      NearbyStations(),
                      //Recents
                      SizedBox(
                        height: 15,
                      ),
                      // Nearby stations
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recents",
                            style: TextStyle(
                                color: darkGrey,
                                fontSize: 14,
                                fontFamily: 'UberMoveMedium'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: PlaceList(),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
