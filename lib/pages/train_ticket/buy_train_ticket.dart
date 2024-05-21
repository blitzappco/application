import 'package:application/pages/train_ticket/choose_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BuyTrainTicket extends StatefulWidget {
  const BuyTrainTicket({super.key});

  @override
  State<BuyTrainTicket> createState() => _BuyTrainTicketState();
}

class _BuyTrainTicketState extends State<BuyTrainTicket> {
  final _departureController = TextEditingController();
  final _destinationController = TextEditingController();
  final _passengersController = TextEditingController();
  DateTime? _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _searchTickets() {
    // Here you can add the functionality to handle the search action.
    // For now, we'll just print the inputs to the console.
    print('Departure: ${_departureController.text}');
    print('Destination: ${_destinationController.text}');
    print('Passengers: ${_passengersController.text}');
    print('Date: ${_selectedDate?.toLocal().toString().split(' ')[0]}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Train Ticket Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _departureController,
                decoration: InputDecoration(
                  labelText: 'Departure Place',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _destinationController,
                decoration: InputDecoration(
                  labelText: 'Destination',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: _passengersController,
                      decoration: InputDecoration(
                        labelText: 'No. of Passengers',
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: _presentDatePicker,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Date',
                          border: InputBorder.none,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              _selectedDate == null
                                  ? 'No Date Chosen!'
                                  : '${_selectedDate?.toLocal().toString().split(' ')[0]}',
                            ),
                            Icon(Icons.calendar_today, color: Colors.grey[600]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChooseLinePage()),
                  );
                },
                child: Text('Search Tickets')),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _departureController.dispose();
    _destinationController.dispose();
    _passengersController.dispose();
    super.dispose();
  }
}
