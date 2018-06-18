import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rnt_proj/models/tenant.dart';
import 'package:rnt_proj/app-const.dart';

class TenantDetailState extends StatefulWidget{
  final Tenant tenant;
  TenantDetailState(this.tenant);
  @override
  State<StatefulWidget> createState() {
    return new TenantDetailPage(tenant);
  }
}

class TenantDetailPage extends State<TenantDetailState>{
  final Tenant tenant;
  TenantDetailPage(this.tenant);
  final tntObj = new List<Tenant>();
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTnt();
  }

  _fetchTnt() async {
    final url = serverPath+'tenant/'+tenant.id.toString();
    print('Fetching '+url);
    final response = await http.get(url);
    final tntJson = json.decode(response.body);
    final tnt = new Tenant(
      tntJson['id'],
      tntJson['first_name'],
      tntJson['last_name'],
      tntJson['id_number'],
      tntJson['mobile'],
      tntJson['amount'],
      tntJson['date_joined'],
    );
    tntObj.add(tnt);
    setState((){
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(tenant.firstName + ' '+ tenant.lastName),
      ),
      body: new Center(
          child
              : _isLoading ? new CircularProgressIndicator()
              : new ListView.builder(
            itemCount: tntObj.length,
            itemBuilder: (context, i){
              final tntDisplay = tntObj[i];
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
                              new Text(
                                tntDisplay.firstName+' '+tntDisplay.lastName,
                                style: new TextStyle(fontWeight: FontWeight.bold),),
                              new Container(height: 4.0),
                              new Text('Date joined: '+tntDisplay.dateJoined),
                              new Container(height: 4.0),
                              new Text('ID Number: ' +tntDisplay.idNumber.toString()),
                              new Container(height: 4.0),
                              new Text('Mobile Number: '+tntDisplay.mobileNumber.toString()),
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
