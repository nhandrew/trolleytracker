import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:trolly_tracker/src/models/station.dart';

import '../models/trolley.dart';

class SeptaService{

  Future<List<Station>> getTrolleyStations() async{
    var stations = await _getStations("101");
    stations.addAll(await _getStations("102"));
    return _removeDuplicateStations(stations);
  }

  Future<List<Trolley>> getTrolleys() async {
    var trolleys = await _getTrolleys("101");
    trolleys.addAll(await _getTrolleys("102"));
    return trolleys;
  }

  Future<List<Station>> _getStations(String route) async {
    var url =  Uri.parse('https://www3.septa.org/hackathon/Stops/$route');
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json as List;
    return jsonResults.map((s) => Station.fromJson(s)).toList();
  }

  Future<List<Trolley>> _getTrolleys(String route) async {
    var url =  Uri.parse('https://www3.septa.org/hackathon/TransitView/trips.php?route=$route');
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['bus'] as List;
    return jsonResults.map((s) => Trolley.fromJson(s)).toList();
  }

  List<Station> _removeDuplicateStations(List<Station> inputList){
    List<Station> d = [];
    for (var s in inputList){
      if (d.indexWhere((existing) => existing.stopName == s.stopName) == -1){
        d.add(s);
      }
    }
   return d;
  }


}