import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trolly_tracker/src/controllers/septa_controller.dart';
import 'package:trolly_tracker/src/services/septa_service.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final septaController = Get.put(SeptaController(SeptaService()));

    return Scaffold(

      appBar: AppBar(
        title: Text('Trolley Tracker'),
      ),
      body: Obx(() => (septaController.stations.isEmpty ) ? Center(child: CircularProgressIndicator()) :  GoogleMap(
        mapType: MapType.normal,
        myLocationButtonEnabled: false,
        markers: Set<Marker>.of(septaController.markers.value),
        initialCameraPosition: CameraPosition(
          target: LatLng(39.951694, -75.292764),
          zoom: 11,
        ),
      ),)
    );
  }
}
