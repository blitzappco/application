import 'package:blitz/bifrost/core/models/place.dart';
import 'package:blitz/bifrost/mantle/models/account.dart';
import 'package:blitz/components/modals/label_modal.dart';
import 'package:blitz/components/search/place_card.dart';
import 'package:blitz/providers/account_provider.dart';
import 'package:blitz/utils/types.dart';
import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeLabel extends StatefulWidget {
  final bool edit;
  final int index;
  const ChangeLabel({required this.edit, required this.index, super.key});

  @override
  State<ChangeLabel> createState() => _ChangeLabelState();
}

class _ChangeLabelState extends State<ChangeLabel> {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  bool unfocused = true;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (unfocused && widget.edit == false) {
        FocusScope.of(context).requestFocus(focusNode);
      }
      unfocused = false;

      if (widget.index > 0) {
        final auth = Provider.of<AccountProvider>(context, listen: false);
        controller.text = auth.account.labels?[widget.index].name ?? '';

        await auth.setLabelPlace(Place.fromLabel(
            auth.account.labels?[widget.index] ?? Label(name: "home")));
      }
    });

    return Consumer<AccountProvider>(builder: (context, auth, _) {
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
                    onTap: () {
                      auth.clearLabelPlace();
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                    ),
                  ),
                  Text(
                    widget.edit ? "Editeaza adresa" : "Adauga adresa",
                    style: const TextStyle(
                        fontFamily: "UberMoveBold", fontSize: 24),
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
                    vertical: 13.0,
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
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  LabelModal.show(context, "to");
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: lightGrey),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: darkGrey,
                          size: 19,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Cauta o locatie...',
                          style: TextStyle(
                              fontSize: 19,
                              fontFamily: 'UberMoveMedium',
                              color: darkGrey),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              if (auth.labelPlace.placeID != "")
                PlaceCard(
                    mainText: auth.labelPlace.mainText,
                    secondaryText: auth.labelPlace.secondaryText ?? '',
                    type: processTypes(auth.labelPlace.types),
                    callback: () async {})
            ],
          ),
        )),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: GestureDetector(
              onTap: () async {
                Navigator.pop(context);
                final label = Label.fromPlace(auth.labelPlace, controller.text);

                if (widget.edit) {
                  await auth.changeLabel(widget.index, label);
                } else {
                  await auth.addLabel(label);
                }
                auth.clearLabelPlace();
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
                        "Salveaza eticheta",
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
    });
  }
}
