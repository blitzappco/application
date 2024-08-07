import 'package:blitz/bifrost/mantle/models/account.dart';

String getFareText(int fare) {
  return (fare / 100).toStringAsFixed(2);
}

String getPMTitle(PaymentMethod? paymentMethod) {
  switch (paymentMethod?.type) {
    case "card":
      String icon = paymentMethod?.icon ?? '';
      return '${icon[0].toUpperCase()}${icon.substring(1)}'
          '  ••••'
          '${paymentMethod?.title ?? ''}';
    case "applepay":
      return 'ApplePay';
    case "googlepay":
      return 'GooglePay';
    default:
      return 'u poor';
  }
}

String getPMIcon(PaymentMethod? paymentMethod) {
  String icon = paymentMethod?.icon ?? '';

  switch (icon) {
    case "visa":
      return 'assets/images/visa-color_large.png';
    case "mastercard":
      return 'assets/images/mastercard-color_large.png';
    case "applepay":
      return 'assets/images/ApplePay.png';

    default:
      return 'assets/images/payment-method.png';
  }
}
