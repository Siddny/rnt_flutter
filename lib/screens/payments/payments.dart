import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rnt_proj/models/payment.dart';
import 'package:rnt_proj/app-const.dart';
import 'package:rnt_proj/models/tenant.dart';
import 'package:rnt_proj/screens/payments/new-payment.dart';

class PaymentState extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return new PaymentScreen();
  }
}

class PaymentScreen extends State<PaymentState> {
  var _isLoading = true;
  final payments = new List<Payment>();

  @override
  void initState() {
    super.initState();
    _fetchPayments();
  }

  _fetchPayments() async {
    payments.clear();
    final url = serverPath+'payrents/';
    final res = await http.get(url);
    if (res.statusCode == 200 ){
      print(res.body);
      final paymentsJson = json.decode(res.body);
      paymentsJson.forEach((item) {
        final payment = new Payment(
          item['id'],
          item['tenant'] = new Tenant(
              item['tenant']['id'],
              item['tenant']['first_name'],
              item['tenant']['last_name'],
              item['tenant']['id_number'],
              item['tenant']['mobile'],
              item['tenant']['amount'],
              item['tenant']['date_joined'],
          ), 
          item['amount_received'],
          item['date_paid'],
          item['month_paid_for'],
          item['comments'],
        );
        payments.add(payment);
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
        title: new Text("Payments"),
      ),
      body: new Center(
          child
              : _isLoading ? new CircularProgressIndicator()
              : new ListView.builder(
              itemCount: payments.length,
              itemBuilder: (context, i){
                final item = payments[i];
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
                                  color: Colors.white,     
                                  child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(height: 4.0),
                                      new Text(item.amountReceived.toString(),
                                          style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                                      new Text(item.monthPaidFor,
                                          style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                                      new Container(height: 4.0),
                                    ],
                                ),
                                  onPressed: () {
                                    // Navigator.push(
                                    //     context,
                                    //     new MaterialPageRoute(
                                    //         builder: (context) =>
                                    //         new PaymentDetailState(item)
                                    //     )
                                    // );
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
        tooltip: 'Add new payment',
        onPressed: (){
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                  new NewPaymentState()
              )
          );
        },
      ),
    );
  }
}