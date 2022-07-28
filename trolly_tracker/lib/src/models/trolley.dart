class Trolley {
  final double lat;
  final double lng;
  final String direction;
  final String vehicleId;

  Trolley(
      {required this.lat,
        required this.lng,
        required this.direction,
        required this.vehicleId});

  factory Trolley.fromJson(Map<dynamic, dynamic> json) {
    return Trolley(
        lat: double.parse(json['lat'].toString()),
        lng: double.parse(json['lng'].toString()),
        direction: json['Direction'],
        vehicleId: json['VehicleID']);
  }
}
