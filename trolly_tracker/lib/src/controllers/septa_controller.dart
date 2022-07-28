
import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trolly_tracker/src/services/septa_service.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;
import 'dart:typed_data';

import '../models/station.dart';
import '../models/trolley.dart';

class SeptaController extends GetxController{
  SeptaService septaService;

  final stations = RxList(<Station>[]);
  final trolleys = RxList(<Trolley>[]);
  final markers = RxList(<Marker>[]);
  late BitmapDescriptor stationIcon;
  late BitmapDescriptor trolleyIcon;

  SeptaController(this.septaService);

  @override
  void onInit(){
    initialize();
    super.onInit();
  }

  initialize() async{
    stationIcon =  await getBitmapDescriptorFromAssetBytes('assets/icons/icons8-blue-circle-48.png', 50);
    trolleyIcon =  await getBitmapDescriptorFromAssetBytes('assets/icons/icons8-trolleybus-64.png', 124);
    stations.value = await septaService.getTrolleyStations();
    await refreshMap();
    Timer.periodic(Duration(seconds: 15), (Timer t) => refreshMap());
  }


  //Functions
  _addStationMarkers(List<Station> stations) {
    for (var s in stations) {
      markers.add(
          Marker(
              markerId: MarkerId(s.stopId),
              infoWindow: InfoWindow(title: s.stopName),
              position: LatLng(s.lat, s.lng),
              icon: stationIcon
          )
      );
    }
  }

    _addTrolleyMarkers(List<Trolley> trolleys) async {
      for (var t in trolleys) {
        markers.add(
            Marker(
                markerId: MarkerId(t.vehicleId),
                infoWindow: InfoWindow(title: t.direction),
                position: LatLng(t.lat, t.lng),
                icon: trolleyIcon
            )
        );
      }
    }


    Future<Uint8List?> _getBytesFromAsset(String path, int width) async {
      ByteData data = await rootBundle.load(path);
      ui.Codec codec = await ui.instantiateImageCodec(
          data.buffer.asUint8List(), targetWidth: width);
      ui.FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ui.ImageByteFormat.png))?.buffer
          .asUint8List();
    }

    Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(String path,
        int width) async {
      final Uint8List? imageData = await _getBytesFromAsset(path, width);
      return BitmapDescriptor.fromBytes(imageData!);
    }

    refreshMap() async {
      trolleys.value = await septaService.getTrolleys();

      _addStationMarkers(stations.value);
      _addTrolleyMarkers(trolleys.value);
      markers.refresh();
    }
  }

