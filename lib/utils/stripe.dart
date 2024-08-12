import 'dart:io';

import 'package:blitz/bifrost/mantle/models/account.dart' as bifrost;
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

Future<bool> checkPlatformPay() async {
  return await Stripe.instance.isPlatformPaySupported(
      googlePay: const IsGooglePaySupportedParams(testEnv: true));
}

Future<bifrost.PaymentMethod> getPlatformPaymentMethod() async {
  bifrost.PaymentMethod platformPM = bifrost.PaymentMethod();
  if (Platform.isAndroid) {
    platformPM = bifrost.PaymentMethod(
        id: 'googlepay',
        type: 'googlepay',
        icon: 'googlepay',
        title: 'googlepay');
  }
  if (Platform.isIOS) {
    platformPM = bifrost.PaymentMethod(
        id: 'applepay', type: 'applepay', icon: 'applepay', title: 'applepay');
  }
  return platformPM;
}

Future<List<bifrost.PaymentMethod>> addPlatformPaymentMethod(
    List<bifrost.PaymentMethod> accountPMList) async {
  final check = await checkPlatformPay();
  if (check) {
    final pm = await getPlatformPaymentMethod();
    List<bifrost.PaymentMethod> pmList = [];
    pmList.add(pm);
    pmList = pmList + accountPMList;
    return pmList;
  } else {
    return accountPMList;
  }
}
