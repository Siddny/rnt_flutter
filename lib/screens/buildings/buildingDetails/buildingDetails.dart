import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rnt_proj/models/building.dart';
import 'package:rnt_proj/app-const.dart';

class BuildingDetailState extends StatefulWidget{
  final Building building;
  BuildingDetailState(this.building);
  @override
  State<StatefulWidget> createState() {
    return new BuildingDetailPage(building);
  }
}

class BuildingDetailPage extends State<BuildingDetailState>{
  final Building building;
  BuildingDetailPage(this.building);
  final buildingObj = new List<Building>();
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBuilding();
  }

  _fetchBuilding() async {
    final url = serverPath+'buildings/'+building.id.toString();
    print('Fetching '+url);
    final response = await http.get(url);
    print(response.body);
    final buildingJson = json.decode(response.body);
    buildingJson.forEach((buildingDict){
      final spficBuilding = new Building(
        buildingDict['id'],
        buildingDict['name'],
        buildingDict['units'],
        buildingDict['address']
      );
      buildingObj.add(spficBuilding);
    });

    setState((){
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(building.buildingName),
      ),
      body: new Center(
          child
              : _isLoading ? new CircularProgressIndicator()
              : new ListView.builder(
            itemCount: buildingObj.length,
            itemBuilder: (context, i){
              final buildingDisplay = buildingObj[i];
              return  new Column(
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.all(12.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Flexible(
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(buildingDisplay.buildingName),
                              new Container(height: 4.0),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          )
      ),
    );
  }
}