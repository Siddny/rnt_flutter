import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rnt_proj/models/house.dart';
import 'package:rnt_proj/screens/houses/houseDetails/houseDetails.dart';
import 'package:rnt_proj/screens/houses/new-house.dart';
import 'package:rnt_proj/app-const.dart';

class HouseState extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return new HouseScreen();
  }
}

class HouseScreen extends State<HouseState> {
  var _isLoading = true;
  final houses = new List<House>();

  @override
  void initState() {
    super.initState();
    _fetchHouses();
  }

  _fetchHouses() async {
    houses.clear();
    final url = serverPath+'houses/';
    final res = await http.get(url);
    if (res.statusCode == 200 ){
      print(res.body);
      final housesJson = json.decode(res.body);
      housesJson.forEach((item) {
        final house = new House(
            item['id'],
            item['house_name'],
        );
        houses.add(house);
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
        title: new Text("Houses"),
      ),
      body: new Center(
          child
              : _isLoading ? new CircularProgressIndicator()
              : new ListView.builder(
              itemCount: houses.length,
              itemBuilder: (context, i){
                final item = houses[i];
                return new Column(
                  children: <Widget>[
                    new Container(
                      padding: new EdgeInsets.all(12.0),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Flexible(
                              child: new SizedBox(
                                height:50.0,
                                child: new RaisedButton(
                                  color: Colors.white,     child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Text(item.houseName,
                                        style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                                    new Container(height: 4.0),
                                  ],
                                ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                            new HouseDetailState(item)
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
        tooltip: 'Add new house',
        onPressed: (){
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                  new NewHouseState()
              )
          );
        },
      ),
    );
  }
}