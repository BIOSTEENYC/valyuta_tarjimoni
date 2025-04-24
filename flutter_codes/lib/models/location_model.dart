class Location {
  final String county;
  final String city;
  final String state;

  Location({required this.county, required this.city, required this.state});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      county: json['address']['county'] ?? 'Unknown',
      city: json['address']['city'] ?? 'Unknown',
      state: json['address']['state'] ?? 'Unknown',
    );
  }
}
