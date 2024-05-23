import 'package:application/components/payment_methods.dart';
import 'package:application/providers/tickets_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class BuyPassPage extends StatefulWidget {
  const BuyPassPage({super.key});

  @override
  State<BuyPassPage> createState() => _BuyPassPageState();
}

class _BuyPassPageState extends State<BuyPassPage> {
  String _selectedTicketType = 'Ticket';
  String _selectedTicketDetail = 'Single Ride';

  final Map<String, List<String>> _ticketDetails = {
    'Ticket': ['Single Ride', '2 Rides', '10 Rides'],
    'Pass': [
      'Daily Pass',
      '3 Days Pass',
      'Weekly Pass',
      'Monthly Pass',
      '6 Months Pass',
      'Yearly Pass'
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<TicketsProvider>(builder: (context, tickets, _) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color.fromARGB(255, 222, 222, 222),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.close,
                                color: Colors.grey[600],
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Buy passes',
                      style:
                          TextStyle(fontFamily: "UberMoveBold", fontSize: 28),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Select Ticket Type',
                      style:
                          TextStyle(fontFamily: "UberMoveMedium", fontSize: 18),
                    ),
                    Container(
                      width: double.infinity,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedTicketType,
                        items: ['Ticket', 'Pass'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedTicketType = newValue!;
                            _selectedTicketDetail =
                                _ticketDetails[_selectedTicketType]!.first;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Select Ticket Detail',
                      style:
                          TextStyle(fontFamily: "UberMoveMedium", fontSize: 18),
                    ),
                    Container(
                      width: double.infinity,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedTicketDetail,
                        items: _ticketDetails[_selectedTicketType]!
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedTicketDetail = newValue!;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(height: 100, child: PaymentMethods())
                  ],
                ),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "10",
                          style: TextStyle(
                              fontFamily: "UberMoveBold", fontSize: 50),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Text(
                            "RON",
                            style: TextStyle(
                                fontFamily: "UberMoveMedium", fontSize: 22),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        tickets.setDisabled(false);
                        Navigator.pop(context);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 156, 57, 255),
                              borderRadius: BorderRadius.circular(40)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Buy",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "UberMoveMedium",
                                      fontSize: 18),
                                )
                              ],
                            ),
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
