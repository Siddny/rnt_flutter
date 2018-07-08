import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rnt_proj/models/building.dart';
import 'package:rnt_proj/screens/buildings/buildingDetails/buildingDetails.dart';
import 'package:rnt_proj/screens/buildings/new-building.dart';
import 'package:rnt_proj/app-const.dart';

class BuildingState extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return new BuildingScreen();
  }
}

class BuildingScreen extends State<BuildingState> {
  var _isLoading = true;
  final buildings = new List<Building>();

  @override
  void initState() {
    super.initState();
    _fetchBuildings();
  }

  _fetchBuildings() async {
    buildings.clear();
    final url = serverPath+'buildings/';
    final res = await http.get(url);
    if (res.statusCode == 200 ){
      print(res.body);
      final buildingsJson = json.decode(res.body);
      buildingsJson.forEach((item) {
        final building = new Building(
            item['id'],
            item['name'],
            item['units'],
            item['address'],
        );
        buildings.add(building);
      });
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Buildings"),
      ),
      body: new Center(
          child
              : _isLoading ? new CircularProgressIndicator()
              : new ListView.builder(
              itemCount: buildings.length,
              itemBuilder: (context, i){
                final item = buildings[i];
                return new Column(
                  children: <Widget>[
                    new Container(
                      padding: new EdgeInsets.all(12.0),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Flexible(
                              child: new SizedBox(
                                height:60.0,
                                child: new RaisedButton(
                                  color: Colors.white,     child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Container(height: 4.0),
                                    new Text('Name: '+item.buildingName,
                                        style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                                    new Text('Units: '+item.units.toString(),
                                        style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                                    new Text('Address: '+item.address,
                                        style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                                    new Container(height: 4.0),
                                  ],
                                ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                            new BuildingDetailState(item)
                                        )
                                    );
                                  },
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }
          )
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        tooltip: 'Add new building',
        onPressed: (){
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                  new NewBuildingState()
              )
          );
        },
      ),
    );
  }
}