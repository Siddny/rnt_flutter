import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rnt_proj/models/house.dart';
import 'package:rnt_proj/screens/houses/new-house-service.dart';

class NewHouseState extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return new NewHouseScreen();
  }
}

class NewHouseScreen extends State<NewHouseState>{
  NewHouseScreen();
  final newHouseObj = new List<NewHouse>();
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  NewHouse newHouse= new NewHouse();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController houseNameController = new TextEditingController();
  final TextEditingController houseNumberController = new TextEditingController();

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
      print('Form save called, newHouseis now up to date...');
      print('House Name: ${newHouse.houseName}');
      print('========================================');
      var userService = new NewHouseService();
      userService.createHouse(newHouse)
          .then((value) =>
          showMessage('New house created ${value.houseName}!', Colors.blue)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final houseName = TextFormField(
      autofocus: false,
      validator: (value) =>
      value.isEmpty ? 'Please enter the house name' : null,
      onSaved: (value) => newHouse.houseName = value,
      controller: houseNameController,
      decoration: InputDecoration(
        hintText: 'House Name',
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
            houseNameController.clear();
          },
          color: Theme.of(context).accentColor,
          child: Text(
            'Add New House',
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
        title: new Text("New House"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              houseName,
              SizedBox(height: 14.0),
              register
            ],
          ),
        ),
      ),
    );
  }
}
