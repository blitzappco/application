import 'package:blitz/bifrost/mantle/models/account.dart';
import 'package:blitz/components/search/label_card_manage.dart';
import 'package:blitz/pages/labels/change_label.dart';
import 'package:blitz/providers/account_provider.dart';
import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageLabels extends StatefulWidget {
  const ManageLabels({super.key});

  @override
  State<ManageLabels> createState() => _ManageLabelsState();
}

class _ManageLabelsState extends State<ManageLabels> {
  @override
  Widget build(BuildContext context) {
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
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                    ),
                  ),
                  const Text(
                    "Editeaza adrese",
                    style: TextStyle(fontFamily: "UberMoveBold", fontSize: 24),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              // // this is where the list view  should start
              // LabelCardManage(label: Label(name: "home")),
              // const SizedBox(
              //   height: 10,
              // ),
              // LabelCardManage(label: Label(name: "work")),

              Expanded(
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemCount: auth.account.labels!.length + 1,
                  itemBuilder: (context, index) => (index !=
                          auth.account.labels!.length)
                      ? LabelCardManage(
                          label: auth.account.labels?[index] ??
                              Label(name: "home"),
                          index: index)
                      : Column(
                          children: [
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const ChangeLabel(
                                              edit: false,
                                            )));
                              },
                              child: const Row(
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
                            ),
                          ],
                        ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                ),
              ),
              // this is where the list view should end
              const SizedBox(
                height: 15,
              ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const ChangeLabel(
              //                   edit: false,
              //                 )));
              //   },
              //   child: const Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Icon(
              //         Icons.add,
              //         color: darkGrey,
              //       ),
              //       Text(
              //         "Adauga o adresa",
              //         style: TextStyle(
              //             fontFamily: "UberMoveMedium",
              //             color: darkGrey,
              //             fontSize: 18),
              //       )
              //     ],
              //   ),
              // )
            ],
          ),
        )),
      );
    });
  }
}
