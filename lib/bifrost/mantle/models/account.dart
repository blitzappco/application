import 'package:blitz/bifrost/core/models/place.dart';

class Label {
  String? placeID;
  String? name;
  String? address;
  String? type;

  Label({
    this.placeID,
    this.name,
    this.address,
    this.type,
  });

  factory Label.fromJSON(Map<String, dynamic> json) {
    return Label(
      placeID: json['placeID'],
      name: json['name'],
      address: json['address'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> accountJSON = <String, dynamic>{
      'placeID': placeID,
      'type': type,
      'name': name,
      'address': address,
    };

    return accountJSON;
  }
}

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
  List<Label>? labels;

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
