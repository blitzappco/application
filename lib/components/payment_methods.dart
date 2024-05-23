import 'package:flutter/material.dart';

class PaymentMethod {
  final String cardNumber;
  final String cardType;

  PaymentMethod({required this.cardNumber, required this.cardType});
}

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({super.key});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  String? _selectedCard;

  final List<PaymentMethod> _paymentMethods = [
    PaymentMethod(cardNumber: '**** **** **** 1234', cardType: 'Visa'),
    PaymentMethod(cardNumber: '**** **** **** 5678', cardType: 'Mastercard'),
    PaymentMethod(cardNumber: '**** **** **** 9012', cardType: 'Visa'),
  ];

  Widget _getCardLogo(String cardType) {
    switch (cardType) {
      case 'Visa':
        return Image.asset('assets/images/visa.png', width: 50, height: 50);
      case 'Mastercard':
        return Image.asset('assets/images/mastercard.png',
            width: 50, height: 50);
      default:
        return Container(
            width: 50, height: 50); // Placeholder for unknown types
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _paymentMethods.length,
      itemBuilder: (context, index) {
        final method = _paymentMethods[index];
        return ListTile(
          leading: Radio<String>(
            value: method.cardNumber,
            groupValue: _selectedCard,
            onChanged: (String? value) {
              setState(() {
                _selectedCard = value;
              });
            },
          ),
          title: Text(method.cardNumber),
          trailing: _getCardLogo(method.cardType),
        );
      },
    );
  }
}
