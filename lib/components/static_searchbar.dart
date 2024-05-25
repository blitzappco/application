import 'package:blitz/components/modals/search_modal.dart';
import 'package:flutter/material.dart';
import '../utils/vars.dart';
// import 'modals/search_modal.dart';

class StaticSearchbar extends StatefulWidget {
  const StaticSearchbar({super.key});

  @override
  State<StaticSearchbar> createState() => _StaticSearchbarState();
}

class _StaticSearchbarState extends State<StaticSearchbar> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SearchModal.show(context, "to");
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: lightGrey),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
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
                'Where are we going?',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'UberMoveMedium',
                    color: darkGrey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
