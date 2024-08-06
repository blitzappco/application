import 'package:blitz/bifrost/core/models/place.dart';
import 'package:blitz/providers/route_provider.dart';
import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';
import 'package:blitz/bifrost/mantle/models/account.dart';
import 'package:provider/provider.dart';

class LabelCard extends StatelessWidget {
  final Label label;
  final int index;
  const LabelCard({
    required this.label,
    required this.index,
    super.key,
  });

  String getAddress(Label label) {
    if (label.name == 'home' || label.name == 'work') {
      if (label.address == "") {
        return 'Seteaza';
      }
    }
    return label.address ?? 'Seteaza';
  }

  String getName(Label label) {
    switch (label.name) {
      case 'home':
        return 'Acasa';
      case 'work':
        return 'Serviciu';
      default:
        return label.name ?? "";
    }
  }

  IconData getIcon(Label label) {
    switch (label.name) {
      case 'home':
        return Icons.home;
      case 'work':
        return Icons.work;
      default:
        return placeIcons[label.type ?? 'general'] ?? Icons.flag;
    }
  }

  Color getColor(Label label) {
    switch (label.name) {
      case 'home':
        return Colors.blue;
      case 'work':
        return Colors.orange;
      default:
        return placeColors[label.type ?? 'general'] ?? blitzPurple;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Consumer<RouteProvider>(builder: (context, route, _) {
      return GestureDetector(
        onTap: () async {
          if (label.placeID != "") {
            Navigator.pop(context);
            await route.setTo(Place.fromLabel(label));
            await route.changePage("preview");
            await route.getRoutes();
          }
        },
        child: Container(
          width: screenWidth * 0.37,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color:
                    const Color.fromARGB(255, 209, 209, 209).withOpacity(0.5),
                spreadRadius: -1,
                blurRadius: 9,
                offset: const Offset(0, 1), // changes position of shadow
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
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  // Use Expanded to take up remaining space
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        getName(label),
                        style: const TextStyle(
                            fontSize: 16, fontFamily: "UberMoveBold"),
                      ),
                      Text(
                        getAddress(label),
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
              ],
            ),
          ),
        ),
      );
    });
  }
}
