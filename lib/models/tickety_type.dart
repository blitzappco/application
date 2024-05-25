class TicketType {
  String? id;
  String? city;

  String? mode;
  int? fare;
  int? trips;
  String? expiry;

  TicketType({
    this.id,
    this.city,
    this.mode,
    this.fare,
    this.trips,
    this.expiry,
  });

  factory TicketType.fromJSON(Map<String, dynamic> json) {
    return TicketType(
      id: json['id'],
      city: json['city'],
      mode: json['mode'],
      fare: json['fare'],
      trips: json['trips'],
      expiry: json['expiry'],
    );
  }
}
