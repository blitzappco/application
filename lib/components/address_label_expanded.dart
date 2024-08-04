import 'package:blitz/pages/search_address_label.dart';
import 'package:flutter/material.dart';

class AddressLabelExpanded extends StatelessWidget {
  final String label;
  final String address;
  const AddressLabelExpanded({
    required this.label,
    required this.address,
    super.key,
  });

  //Gets the icon type
  IconData getIcon(String label) {
    switch (label.toLowerCase()) {
      case 'acasa':
        return Icons.home;
      case 'serviciu':
        return Icons.work;
      default:
        return Icons.flag;
    }
  }

  Color getColor(String label) {
    switch (label.toLowerCase()) {
      case 'acasa':
        return Colors.blue;
      case 'serviciu':
        return Colors.orange;
      default:
        return Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SearchAddressLabel(
                      edit: true,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 209, 209, 209).withOpacity(0.5),
              spreadRadius: -1,
              blurRadius: 9,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: getColor(label),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Icon(
                    getIcon(label),
                    size: 25,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                // Use Expanded to take up remaining space
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style:
                          TextStyle(fontSize: 16, fontFamily: "UberMoveBold"),
                    ),
                    Text(
                      address,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: "UberMoveMedium",
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Container(
                      color: Colors.transparent,
                      width: 15,
                      height: 20,
                    ),
                    Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
