import 'package:application/models/place.dart';

class PaymentMethod {
  String? id;
  String? type;
  String? icon;
  String? title;

  PaymentMethod({
    this.id,
    this.type,
    this.icon,
    this.title,
  });

  factory PaymentMethod.fromJSON(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'],
      type: json['type'],
      icon: json['icon'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> accountJSON = <String, dynamic>{
      'id': id,
      'type': type,
      'icon': icon,
      'title': title,
    };

    return accountJSON;
  }
}

class Account {
  String? id;
  String? phone;
  String? firstName;
  String? lastName;
  String? stripeCustomerID;
  List<PaymentMethod>? paymentMethods;
  List<Place>? trips;

  Account({
    this.id,
    this.phone,
    this.firstName,
    this.lastName,
    this.stripeCustomerID,
    this.paymentMethods,
  });

  factory Account.fromJSON(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      phone: json['phone'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      stripeCustomerID: json['stripeCustomerID'],
    );
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> accountJSON = <String, dynamic>{
      'id': id,
      'phone': phone,
      'firstName': firstName,
      'lastName': lastName,
      'stripeCustomerID': stripeCustomerID,
    };

    return accountJSON;
  }
}
