class Ticket {
  String? id;
  String? accountID;
  String? city;

  String? mode;
  int? fare;
  int? trips;
  String? expiry;

  String? paymentIntent;
  bool? confirmed;

  DateTime? expiresAt;
  DateTime? createdAt;

  Ticket({
    this.id,
    this.accountID,
    this.city,
    this.mode,
    this.fare,
    this.trips,
    this.expiry,
    this.paymentIntent,
    this.confirmed,
    this.expiresAt,
    this.createdAt,
  });

  factory Ticket.fromJSON(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      accountID: json['accountID'],
      city: json['city'],
      mode: json['mode'],
      fare: json['fare'],
      trips: json['trips'],
      expiry: json['expiry'],
      paymentIntent: json['paymentIntent'],
      confirmed: json['confirmed'],
      expiresAt: DateTime.parse(json['expiresAt']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJSON() {
    return <String, dynamic>{
      'id': id,
      'accountID': accountID,
      'city': city,
      'mode': mode,
      'fare': fare,
      'trips': trips,
      'expiry': expiry,
      'paymentIntent': paymentIntent,
      'confirmed': confirmed,
      'expiresAt': expiresAt,
      'createdAt': createdAt,
    };
  }
}
