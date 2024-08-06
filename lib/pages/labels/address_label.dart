import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';

class AddressLabel extends StatefulWidget {
  final bool edit;
  const AddressLabel({required this.edit, super.key});

  @override
  State<AddressLabel> createState() => _AddressLabelState();
}

TextEditingController controller = TextEditingController();
FocusNode focusNode = FocusNode();

bool unfocused = true;

class _AddressLabelState extends State<AddressLabel> {
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
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 20,
                  ),
                ),
                Text(
                  widget.edit ? "Editeaza adresa" : "Adauga adresa",
                  style:
                      const TextStyle(fontFamily: "UberMoveBold", fontSize: 24),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            const SizedBox(
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
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Cauta o locatie',
                          hintStyle: TextStyle(
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
          ],
        ),
      )),
    );
  }
}
