import 'package:flutter/material.dart';

class Buypass extends StatefulWidget {
  const Buypass({Key? key});

  @override
  State<Buypass> createState() => _BuypassState();
}

class _BuypassState extends State<Buypass> {
  String? selectedType; // To store the selected type (Ticket or Subscription)
  String? selectedOption; // To store the selected ticket/subscription type
  Map<String, Map<String, dynamic>> tickets = {
    // Define your ticket types with their corresponding prices and validity
    'One Ride': {'price': 1.5, 'validity': '1 Ride'},
    'Day Pass': {'price': 5.0, 'validity': '1 Day'},
    'Weekly Pass': {'price': 20.0, 'validity': '7 Days'},
    'Monthly Pass': {'price': 75.0, 'validity': '30 Days'},
  };
  Map<String, Map<String, dynamic>> subscriptions = {
    // Define your subscription types with their corresponding prices and validity
    'Basic': {'price': 5, 'validity': '1 Month'},
    'Standard': {'price': 10, 'validity': '3 Months'},
    'Premium': {'price': 20, 'validity': '6 Months'},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOption = null; // Reset selected option
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5.0,
                          left: 10.0), // Adjust left padding as needed
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.grey[600],
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(), // Add Spacer to push the back button to the left and other content to the right
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(
                          context); // Navigate back to the previous screen
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5.0,
                          right: 10.0), // Adjust right padding as needed
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.close,
                            color: Colors.grey[600],
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: Column(
                        children: [
                          Icon(Icons.confirmation_num,
                              size: 60, color: Colors.blue),
                          SizedBox(height: 10),
                          Text(
                            selectedType != null
                                ? 'Buy $selectedType'
                                : 'Buy passes',
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'UberMedium',
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Available fares',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                  fontFamily: 'UberMedium',
                ),
              ),
              SizedBox(height: 10),
              if (selectedType == null)
                Column(
                  children: [
                    _buildOptionCard('Ticket', tickets),
                    SizedBox(height: 10),
                    _buildOptionCard('Subscription', subscriptions),
                  ],
                ),
              if (selectedType != null)
                Column(
                  children: [
                    if (selectedOption == null)
                      _buildOptionsList(
                        selectedType == 'Ticket' ? tickets : subscriptions,
                      ),
                    if (selectedOption != null) _buildSummaryCard(),
                  ],
                ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(
    String title,
    Map<String, Map<String, dynamic>> options,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: ListTile(
        onTap: () {
          setState(() {
            selectedType = title;
            selectedOption = null;
          });
        },
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontFamily: 'UberMedium'),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
      ),
    );
  }

  Widget _buildOptionsList(
    Map<String, Map<String, dynamic>> options,
  ) {
    return Column(
      children: options.keys.map((option) {
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 3,
          child: ListTile(
            onTap: () {
              setState(() {
                selectedOption = option;
              });
            },
            title: Text(
              option,
              style: TextStyle(fontSize: 18, fontFamily: 'UberMedium'),
            ),
            trailing: Text(
              '\$${options[option]!['price']}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
                fontFamily: 'UberMedium',
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSummaryCard() {
    final options = selectedType == 'Ticket' ? tickets : subscriptions;
    final optionDetails = options[selectedOption!];
    return Column(
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedOption!,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'UberMedium',
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Price: \$${optionDetails!['price']}',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'UberMedium',
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Validity: ${optionDetails['validity']}',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'UberMedium',
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Implement payment logic here
                    print('Payment action for $selectedOption');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Center(
                    child: Text(
                      'Pay',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'UberMedium',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
