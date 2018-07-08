import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rnt_proj/models/payment.dart';
import 'package:rnt_proj/app-const.dart';

class PaymentDetailState extends StatefulWidget{
  final Payment payment;
  PaymentDetailState(this.payment);
  @override
  State<StatefulWidget> createState() {
    return new PaymentDetailPage(payment);
  }
}

class PaymentDetailPage extends State<PaymentDetailState>{
  final Payment payment;
  PaymentDetailPage(this.payment);
  final paymentObj = new List<Payment>();
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPayment();
  }

  _fetchPayment() async {
    final url = serverPath+'payments/'+payment.id.toString();
    print('Fetching '+url);
    final response = await http.get(url);
    print(response.body);
    final paymentJson = json.decode(response.body);
    paymentJson.forEach((paymentDict){
      final spficPayment = new Payment(
        paymentDict['id'],
        paymentDict['tenant'],
        paymentDict['amount'],
        paymentDict['date_paid'],
        paymentDict['month_paid_for'],
        paymentDict['comments'],
      );
      paymentObj.add(spficPayment);
    });

    setState((){
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(payment.monthPaidFor + payment.amountReceived.toString()),
      ),
      body: new Center(
          child
              : _isLoading ? new CircularProgressIndicator()
              : new ListView.builder(
            itemCount: paymentObj.length,
            itemBuilder: (context, i){
              final paymentDisplay = paymentObj[i];
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
                              new Text(paymentDisplay.amountReceived.toString()),
                              new Container(height: 4.0),
                              new Text(paymentDisplay.datePaid),
                              new Container(height: 4.0),
                              new Text(paymentDisplay.monthPaidFor),
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