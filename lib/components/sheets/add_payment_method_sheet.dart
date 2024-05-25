import 'package:application/providers/account_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

class AddPaymentMethodSheet {
  Future<void> handle(BuildContext context) async {
    final account = Provider.of<AccountProvider>(context, listen: false);
    await account.createSetupIntent();
    await Stripe.instance
        .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                setupIntentClientSecret: account.clientSecret,
                style: ThemeMode.light,
                merchantDisplayName: 'Blitz',
                applePay: const PaymentSheetApplePay(
                  buttonType: PlatformButtonType.setUp,
                  merchantCountryCode: 'RO',
                ),
                googlePay:
                    const PaymentSheetGooglePay(merchantCountryCode: 'RO'),
                billingDetails: BillingDetails(
                    phone: account.account.phone ?? '',
                    name:
                        '${account.account.lastName} ${account.account.firstName}'),
                billingDetailsCollectionConfiguration:
                    const BillingDetailsCollectionConfiguration(
                  address: AddressCollectionMode.full,
                  phone: CollectionMode.never,
                )))
        .then((value) {});
  }
}
