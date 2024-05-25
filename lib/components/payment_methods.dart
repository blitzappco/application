import 'package:blitz/providers/account_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({super.key});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  Widget getCardLogo(String cardType) {
    switch (cardType) {
      case 'visa':
        return Image.asset('assets/images/visa.png', width: 50, height: 50);
      case 'mastercard':
        return Image.asset('assets/images/mastercard.png',
            width: 50, height: 50);
      default:
        return const SizedBox(
            width: 50, height: 50); // Placeholder for unknown types
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(builder: (context, account, _) {
      return ListView.builder(
        itemCount: account.account.paymentMethods?.length ?? 0,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Radio<int>(
              value: index,
              groupValue: account.selectedPM,
              onChanged: (int? value) {
                account.setSelectedPM(value ?? 0);
              },
            ),
            title: Text(account.account.paymentMethods?[index].title ?? ''),
            trailing:
                getCardLogo(account.account.paymentMethods?[index].icon ?? ''),
          );
        },
      );
    });
  }
}
