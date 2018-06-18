import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rnt_proj/models/house.dart';
import 'package:rnt_proj/app-const.dart';

class HouseDetailState extends StatefulWidget{
  final House house;
  HouseDetailState(this.house);
  @override
  State<StatefulWidget> createState() {
    return new HouseDetailPage(house);
  }
}

class HouseDetailPage extends State<HouseDetailState>{
  final House house;
  HouseDetailPage(this.house);
  final houseObj = new List<House>();
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchHouse();
  }

  _fetchHouse() async {
    final url = serverPath+'houses/'+house.id.toString();
    print('Fetching '+url);
    final response = await http.get(url);
    print(response.body);
    final houseJson = json.decode(response.body);
    houseJson.forEach((houseDict){
      final spficHouse = new House(
        houseDict['id'],
        houseDict['house_name'],
      );
      houseObj.add(spficHouse);
    });

    setState((){
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(house.houseName),
      ),
      body: new Center(
          child
              : _isLoading ? new CircularProgressIndicator()
              : new ListView.builder(
            itemCount: houseObj.length,
            itemBuilder: (context, i){
              final houseDisplay = houseObj[i];
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
                              new Text(houseDisplay.houseName),
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