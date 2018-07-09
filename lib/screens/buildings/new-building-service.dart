import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:rnt_proj/models/building.dart';
import 'package:rnt_proj/app-const.dart';

class NewBuildingService {
  static const _serviceUrl = serverPath+'buildings/';
  static final _headers = {'Content-Type': 'application/json'};

  Future<NewBuilding> createBuilding(NewBuilding building) async {
    try {
      String json = _toJson(building);
      final response =
      await http.post(_serviceUrl, headers: _headers, body: json);
      var result = _fromJson(response.body);
      return result;
    } catch (e) {
      print('Server Exception!!!');
      print(e);
      return null;
    }
  }

  NewBuilding _fromJson(String jsonData) {
    Map<String, dynamic> map = json.decode(jsonData);
    var building = new NewBuilding();
    building.buildingName = map['name'];
    building.units = map['units'];
    building.address = map['address'];
    return building;
  }

  String _toJson(NewBuilding building) {
    var mapData = new Map();
    mapData["name"] = building.buildingName;
    mapData["units"] = building.units;
    mapData["address"] = building.address;
    String jsonBody = json.encode(mapData);
    return jsonBody;
  }
}