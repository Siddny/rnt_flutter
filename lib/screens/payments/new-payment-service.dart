import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:rnt_proj/models/payment.dart';
import 'package:rnt_proj/app-const.dart';

class NewPaymentService {
  static const _serviceUrl = serverPath+'payrent/';
  static final _headers = {'Content-Type': 'application/json'};

  Future<NewPayment> createPayment(NewPayment payment) async {
    try {
      String json = _toJson(payment);
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

  NewPayment _fromJson(String jsonData) {
    Map<String, dynamic> map = json.decode(jsonData);
    var payment = new NewPayment();
    payment.amountReceived = map['amount_received'];
    payment.datePaid = map['date_paid'];
    payment.monthPaidFor = map['month_paid_for'];
    payment.tenant = map['tenant'];
    payment.comments = map['comments'];

    return payment;
  }

  String _toJson(NewPayment payment) {
    var mapData = new Map();
    mapData["amount_received"] = payment.amountReceived;
    mapData["date_paid"] = payment.datePaid;
    mapData["month_paid_for"] = payment.monthPaidFor;
    mapData["tenant"] = payment.tenant;
    mapData["comments"] = payment.comments;
    String jsonBody = json.encode(mapData);

    return jsonBody;
  }
}