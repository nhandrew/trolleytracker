import 'package:mocktail/mocktail.dart';
import 'package:trolly_tracker/src/models/station.dart';
import 'package:trolly_tracker/src/models/trolley.dart';
import 'package:trolly_tracker/src/services/septa_service.dart';

class MockSeptaService extends Mock implements SeptaService {
  @override
  Future<List<Station>> getTrolleyStations() {
    return Future.delayed(const Duration(seconds: 1), () {
      return [
        Station(stopName: 'Test Stop One', lat: 45.0, lng: 45.0, stopId: '1'),
        Station(stopName: 'Test Stop Two', lat: 46.0, lng: 46.0, stopId: '2')
      ];
    });
  }

  @override
  Future<List<Trolley>> getTrolleys() {
    return Future.delayed(const Duration(seconds: 1), () {
      return [
        Trolley(lat: 45.0,lng: 45.0,direction: 'South',vehicleId: '1'),
        Trolley(lat: 46.0,lng: 46.0,direction: 'North',vehicleId: '2'),
      ];
    });
  }
}

void main() {
  final septaService = MockSeptaService();
}
