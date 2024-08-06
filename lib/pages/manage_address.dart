import 'package:blitz/components/address_label_expanded.dart';
import 'package:blitz/pages/search_address_label.dart';
import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ManageAddress extends StatefulWidget {
  const ManageAddress({super.key});

  @override
  State<ManageAddress> createState() => _ManageAddressState();
}

class _ManageAddressState extends State<ManageAddress> {
  @override
  Widget build(BuildContext context) {
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
                  "Editeaza adrese",
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
            AddressLabelExpanded(
                label: 'Acasa', address: "Dealu cu Piatra 2, Bl. 30, Sc. C"),
            SizedBox(
              height: 10,
            ),
            AddressLabelExpanded(
                label: 'Serviciu', address: "Apasa pentru a seta"),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchAddressLabel(
                              edit: false,
                            )));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: darkGrey,
                  ),
                  Text(
                    "Adauga o adresa",
                    style: TextStyle(
                        fontFamily: "UberMoveMedium",
                        color: darkGrey,
                        fontSize: 18),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
