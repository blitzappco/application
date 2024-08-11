import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> initPaymentSheet(BuildContext context, String clientSecret) async {
  try {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        // Set to true for custom flow
        customFlow: false,
        // Main params
        merchantDisplayName: 'Flutter Stripe Store Demo',
        setupIntentClientSecret: clientSecret,
        // Extra options
        applePay: const PaymentSheetApplePay(
          merchantCountryCode: 'RO',
        ),
        googlePay: const PaymentSheetGooglePay(
          merchantCountryCode: 'RO',
          testEnv: true,
        ),
        style: ThemeMode.dark,
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
    rethrow;
  }
}
