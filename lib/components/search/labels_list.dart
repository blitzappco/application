import 'package:blitz/bifrost/mantle/models/account.dart';
import 'package:blitz/components/search/label_card.dart';
import 'package:blitz/pages/labels/manage_labels.dart';
import 'package:blitz/providers/account_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LabelsList extends StatelessWidget {
  const LabelsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(builder: (context, auth, _) {
      print("LABELS: ${auth.account.labels}");
      return SizedBox(
          height: 70,
          child: ListView.separated(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            itemCount: auth.account.labels!.length + 1,
            itemBuilder: (context, index) => (index !=
                    auth.account.labels?.length)
                ? LabelCard(
                    label: auth.account.labels?[index] ?? Label(name: "home"))
                : GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ManageLabels()));
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 209, 234, 255)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.edit_outlined,
                          color: Colors.blue[800],
                          size: 20,
                        ),
                      ),
                    ),
                  ),
            separatorBuilder: (context, index) => const SizedBox(width: 10),
          ));
    });
  }
}
