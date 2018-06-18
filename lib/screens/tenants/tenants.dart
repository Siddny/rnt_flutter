import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rnt_proj/models/tenant.dart';
import 'package:rnt_proj/screens/tenants/tenantDetails/tenantDetails.dart';
import 'package:rnt_proj/app-const.dart';

class TenantState extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return new TenantScreen();
  }
}

class TenantScreen extends State<TenantState>{
  var _isLoading = true;
  final dataTenant = new List<Tenant>();

  @override
  void initState() {
    super.initState();
    _fetchA();
  }

  _fetchA() async {
    dataTenant.clear();
    final url = serverPath+'tenant/';
    final res = await http.get(url);
    if(res.statusCode == 200 ){
      final aJson = json.decode(res.body);
      aJson.forEach((item){
        final Tenant_dat = new Tenant(
            item['id'],
            item['first_name'],
            item['last_name'],
            item['id_number'],
            item['mobile'],
            item['amount'],
            item['date_joined'],
        );
        dataTenant.add(Tenant_dat);
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
        title: new Text('Tenants'),
      ),
      body: new Center(
          child
              : _isLoading ? new CircularProgressIndicator()
              : new ListView.builder(
              itemCount: dataTenant.length,
              itemBuilder: (context, i){
                final item = dataTenant[i];
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
                                    new Text(item.firstName +' '+ item.lastName,
                                        style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                                    new Container(height: 4.0),
                                  ],
                                ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                            new TenantDetailState(item)));
                                  },
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                    new Divider()
                  ],
                );
              }
          )
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        tooltip: 'Add new tenant',
        onPressed: (){
//          Navigator.push(
//              context,
//              new MaterialPageRoute(
//                  builder: (context) =>
//                  new NewTenantPage()
//              )
//          );
        },
      ),
//      ),
    );
  }
}