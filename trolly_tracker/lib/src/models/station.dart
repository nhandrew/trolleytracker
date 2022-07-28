class Station {
  final double lat;
  final double lng;
  final String stopName;
  final String stopId;

  Station(
      {required this.lat,
      required this.lng,
      required this.stopName,
      required this.stopId});

  factory Station.fromJson(Map<dynamic, dynamic> json) {
    return Station(
        lat: double.parse(json['lat'].toString()),
        lng: double.parse(json['lng'].toString()),
        stopName: json['stopname'],
        stopId: json['stopid']);
  }
}
