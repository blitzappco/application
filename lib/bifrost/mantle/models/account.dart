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
    this.trips,
    this.labels,
  });

  factory Account.fromJSON(Map<String, dynamic> json) {
    List<PaymentMethod> pmList = [];
    for (int i = 0; i < json["paymentMethods"].length; i++) {
      pmList.add(PaymentMethod.fromJSON(json["paymentMethods"][i]));
    }

    List<Place> tripList = [];
    for (int i = 0; i < json["trips"].length; i++) {
      tripList.add(Place.fromTrip(json["trips"][i]));
    }

    List<Label> labelList = [];
    for (int i = 0; i < json["labels"].length; i++) {
      labelList.add(Label.fromJSON(json["labels"][i]));
    }
    return Account(
        id: json['id'],
        phone: json['phone'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        stripeCustomerID: json['stripeCustomerID'],
        paymentMethods: pmList,
        trips: tripList,
        labels: labelList);
  }

  factory Account.fromEmpty() {
    return Account(
        id: '',
        phone: '',
        firstName: '',
        lastName: '',
        stripeCustomerID: '',
        paymentMethods: [],
        trips: [],
        labels: []);
  }

  Map<String, dynamic> toJSON() {
    List<dynamic> pmList = [];
    int pmLength = paymentMethods?.length ?? 0;
    for (int i = 0; i < pmLength; i++) {
      pmList.add(paymentMethods?[i].toJSON());
    }

    List<dynamic> tripList = [];
    int tripLength = trips?.length ?? 0;
    for (int i = 0; i < tripLength; i++) {
      tripList.add(trips?[i].toJSON());
    }

    List<dynamic> labelList = [];
    int labelLength = labels?.length ?? 0;
    for (int i = 0; i < labelLength; i++) {
      labelList.add(labels?[i].toJSON());
    }
    Map<String, dynamic> accountJSON = <String, dynamic>{
      'id': id,
      'phone': phone,
      'firstName': firstName,
      'lastName': lastName,
      'stripeCustomerID': stripeCustomerID,
      'paymentMethods': pmList,
      'trips': tripList,
      'labels': labelList,
    };

    return accountJSON;
  }
}
