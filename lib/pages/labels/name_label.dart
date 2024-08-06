import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';

class NameLabel extends StatefulWidget {
  const NameLabel({super.key});

  @override
  State<NameLabel> createState() => _NameLabelState();
}

TextEditingController controller = TextEditingController();
FocusNode focusNode = FocusNode();

bool unfocused = true;

class _NameLabelState extends State<NameLabel> {
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
                const Text(
                  "Adauga un nume",
                  style: TextStyle(fontFamily: "UberMoveBold", fontSize: 24),
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
                          hintText: 'Scrie numele locatiei',
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
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: GestureDetector(
            onTap: () {
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
                      "Salveaza locatie",
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
        ),
      ),
    );
  }
}
