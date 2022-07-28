import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trolly_tracker/src/controllers/septa_controller.dart';
import 'package:trolly_tracker/src/services/septa_service.dart';

import '../services/septa_service_test.dart';

Future<void> main() async {

  final septaController = SeptaController(MockSeptaService());

  test('Get bitmap descriptor from icon',() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    var icon = await septaController.getBitmapDescriptorFromAssetBytes('assets/icons/icons8-blue-circle-48.png', 50);
    expect(icon, isInstanceOf<BitmapDescriptor>());
  });

  group('Get Trolleys and Stations',() {
    test('initialize controller',() async {
      await septaController.initialize();
    });

    test('Get two stations',() async {
     TestWidgetsFlutterBinding.ensureInitialized();
      await septaController.refreshMap();
      expect(septaController.stations.length,2);
    });

    test('Get two trolleys',() async {
      await septaController.refreshMap();
      expect(septaController.trolleys.length,2);
    });
  });

}