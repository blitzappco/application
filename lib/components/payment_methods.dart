import 'package:blitz/providers/account_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
        return Image.asset('assets/images/visa.svg', width: 50, height: 50);
      case 'mastercard':
        return SvgPicture.asset('assets/images/mastercard.svg',
            width: 50, height: 50);
      case 'googlepay':
        return SvgPicture.asset(
          'assets/images/gpay.png',
          height: 50,
          width: 50,
        );
      default:
        return const SizedBox(
            width: 50, height: 50); // Placeholder for unknown types
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(builder: (context, auth, _) {
      return ListView.builder(
        itemCount: auth.account.paymentMethods?.length ?? 0,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Radio<int>(
              value: index,
              groupValue: auth.selectedPM,
              onChanged: (int? value) {
                auth.setSelectedPM(value ?? 0);
              },
            ),
            title: Text(auth.account.paymentMethods?[index].title ?? ''),
            trailing:
                getCardLogo(auth.account.paymentMethods?[index].icon ?? ''),
          );
        },
      );
    });
  }
}
