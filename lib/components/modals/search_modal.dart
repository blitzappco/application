import 'package:application/components/place_list.dart';
import 'package:flutter/material.dart';

import '../../utils/env.dart';

class SearchModal {
  static void show(BuildContext context, String type) {
    TextEditingController controller = TextEditingController();
    FocusNode focusNode = FocusNode();

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(9),
          topRight: Radius.circular(9),
        ),
      ),
      builder: (BuildContext context) {
        // Schedule the focus request after the bottom sheet is built
        WidgetsBinding.instance.addPostFrameCallback((_) {
          FocusScope.of(context).requestFocus(focusNode);
        });

        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: lightGrey,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 10,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.search,
                                color: darkGrey,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  onChanged: (input) async {
                                    // await route.getPredictions(input);
                                  },
                                  controller: controller,
                                  focusNode: focusNode,
                                  decoration: InputDecoration.collapsed(
                                    hintText: type == 'to'
                                        ? 'Cauta o destinatie'
                                        : 'Cauta o locatie',
                                    hintStyle: const TextStyle(
                                      fontSize: 19,
                                      fontFamily: 'UberMoveMedium',
                                      color: darkGrey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'UberMoveMedium',
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // if (controller.text.isEmpty && trips.trips.isNotEmpty)
                PlaceList(max: 20),
                // if (controller.text.isNotEmpty)
                //   Predictions(
                //       type: type,
                //       callback: () async {
                //         Navigator.pop(context);
                //       })
                // : Predictions(
                //     type: type,
                //     callback: () async {
                //       Navigator.pop(context);
                //     }),
              ],
            ),
          ),
        );
      },
    );
  }
}
