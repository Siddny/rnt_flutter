import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'package:rnt_proj/models/payment.dart';
import 'package:rnt_proj/screens/payments/new-payment-service.dart';

class NewPaymentState extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return new NewPaymentScreen();
  }
}

class User {
  const User(this.name);
  final String name;
}

enum Answer{YES, NO, MAYBE}

class NewPaymentScreen extends State<NewPaymentState>{

  String _answer = '';

  NewPaymentScreen();
  final newPaymentObj = new List<NewPayment>();
  // var _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  void setAnswer(String value){
    setState(() {
      //TODO act on the answer
      _answer = value;
    });
  }

  Future<Null> _askuser() async{
    switch (
      await showDialog(
        context: context,
        child: new SimpleDialog(
          title: new Text('Do you like ? '),
          children: <Widget>[
            new SimpleDialogOption(
              onPressed: (){
                Navigator.pop(context, Answer.NO);},
                child: const Text('Yess!!!'),
            ),
            new SimpleDialogOption(
              onPressed: (){
                Navigator.pop(context, Answer.YES);},
                child: const Text('NO!!!'),
            ),
            new SimpleDialogOption(
              onPressed: (){
                Navigator.pop(context, Answer.MAYBE);},
                child: const Text('Maybe!!!'),
            ),
          ],
        )
      )) {
      case Answer.YES:
        setAnswer('yes');
        break;
      case Answer.NO:
        setAnswer('no');
        break;
      case Answer.MAYBE:
        setAnswer('maybe');
        break;
      default:
    }
  }

  User selectedUser;
  List<User> users = <User>[const User('Foo'), const User('Bar')];

  NewPayment newPayment= new NewPayment();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController tenantController = new TextEditingController();
  final TextEditingController amountReceivedController = new TextEditingController();
  final TextEditingController addressController = new TextEditingController();
  final TextEditingController datePaidController = new TextEditingController();
  final TextEditingController monthPaidForController = new TextEditingController();
  final TextEditingController commentsController = new TextEditingController();

  void showMessage(
      String message,
      [MaterialColor color = Colors.grey]
      ) {
        _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: Theme.of(context).primaryColorDark, content: new Text(message)));
      }

  void _submitForm() {
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      showMessage('Form is not valid!  Please review and correct.');
    } else {
      form.save(); //This invokes each onSaved event
      print('========================================');
      var userService = new NewPaymentService();
      userService.createPayment(newPayment)
          .then((value) =>
          showMessage('New payment created ${value.amountReceived}!', Colors.blue)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tenant = TextFormField(
      autofocus: false,
      validator: (value) =>
      value.isEmpty ? 'Please enter the tenant' : null,
      onSaved: (value) => newPayment.tenant = int.parse(value),
      controller: tenantController,
      decoration: InputDecoration(
        hintText: 'Tenant',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        fillColor: Colors.white,
        filled: true
      ),
    );

    final amountReceived = TextFormField(
      autofocus: false,
      validator: (value) =>
      value.isEmpty ? 'Please enter the number of units' : null,
      onSaved: (value) => newPayment.amountReceived = int.parse(value),
      controller: amountReceivedController,
      decoration: InputDecoration(
        hintText: 'Amount received',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        fillColor: Colors.white,
        filled: true
      ),
    );

    final datePaid = TextFormField(
      autofocus: false,
      validator: (value) =>
      value.isEmpty ? 'Please enter the payment address' : null,
      onSaved: (value) => newPayment.datePaid = value,
      controller: datePaidController,
      decoration: InputDecoration(
        hintText: 'Date paid',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        fillColor: Colors.white,
        filled: true
      ),
    );

    final monthPaidFor = TextFormField(
      autofocus: false,
      validator: (value) =>
      value.isEmpty ? 'Please enter the month Paid For' : null,
      onSaved: (value) => newPayment.monthPaidFor = value,
      controller: monthPaidForController,
      decoration: InputDecoration(
        hintText: 'Month Paid For',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        fillColor: Colors.white,
        filled: true
      ),
    );

    final comments = TextFormField(
      autofocus: false,
      validator: (value) =>
      value.isEmpty ? 'comment' : null,
      onSaved: (value) => newPayment.comments = value,
      controller: commentsController,
      decoration: InputDecoration(
        hintText: 'Comment',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        fillColor: Colors.white,
        filled: true
      ),
    );

    final register = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            _submitForm();
            datePaidController.clear();
            amountReceivedController.clear();
            commentsController.clear();
            tenantController.clear();
            monthPaidForController.clear();
          },
          color: Theme.of(context).accentColor,
          child: Text(
            'Add New Payment',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
//      backgroundColor: Theme.of(context).primaryColor,
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: new Text("New Payment"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              tenant,
              amountReceived,
              monthPaidFor,
              datePaid,
              comments,
              new DropdownButton<User>(
                hint:
                  Text(
                    'Select a user',
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                  ),
                value: selectedUser,
                onChanged: (User newValue) {
                  setState(() {
                    selectedUser = newValue;
                  });
                },
                items: users.map((User user) {
                  return new DropdownMenuItem<User>(
                    value: user,
                    child: new Text(
                      user.name,
                      style: new TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
              new Text('You answered ${_answer}'),
              new RaisedButton(
                child: new Text('Click Me'),
                onPressed: (){
                  _askuser();
                },
              ),
              SizedBox(height: 14.0),
              register
            ],
          ),
        ),
      ),
    );
  }
}
