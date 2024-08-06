import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchAddressLabel extends StatefulWidget {
  final bool edit;
  const SearchAddressLabel({required this.edit, super.key});

  @override
  State<SearchAddressLabel> createState() => _SearchAddressLabelState();
}

TextEditingController controller = TextEditingController();
FocusNode focusNode = FocusNode();

bool unfocused = true;

class _SearchAddressLabelState extends State<SearchAddressLabel> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (unfocused) FocusScope.of(context).requestFocus(focusNode);
      unfocused = false;
    });

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 20,
                  ),
                ),
                Text(
                  widget.edit ? "Editeaza adresa" : "Adauga adresa",
                  style: TextStyle(fontFamily: "UberMoveBold", fontSize: 24),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
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
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        onChanged: (input) async {
                          // await route.getPredictions(input);
                        },
                        controller: controller,
                        focusNode: focusNode,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Cauta o locatie',
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
            // Placelist(
            //     places: route.predictions,
            //     set: route.setFrom,
            //     trip: account.addTrip,
            //     callback: () {
            //       Navigator.pop(context);
            //     }),
          ],
        ),
      )),
    );
  }
}
