import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:rnt_proj/models/house.dart';
import 'package:rnt_proj/app-const.dart';

class NewHouseService {
  static const _serviceUrl = serverPath+'houses/';
  static final _headers = {'Content-Type': 'application/json'};

  Future<NewHouse> createHouse(NewHouse house) async {
    try {
      String json = _toJson(house);
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

  NewHouse _fromJson(String jsonData) {
    Map<String, dynamic> map = json.decode(jsonData);
    var house = new NewHouse();
    house.houseName = map['house_name'];
    return house;
  }

  String _toJson(NewHouse house) {
    var mapData = new Map();
    mapData["house_name"] = house.houseName;
    String jsonBody = json.encode(mapData);
    return jsonBody;
  }
}