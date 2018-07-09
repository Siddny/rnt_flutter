import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'package:rnt_proj/models/building.dart';
import 'package:rnt_proj/screens/buildings/new-building-service.dart';

class NewBuildingState extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return new NewBuildingScreen();
  }
}

class NewBuildingScreen extends State<NewBuildingState>{
  NewBuildingScreen();
  final newBuildingObj = new List<NewBuilding>();
  // var _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  NewBuilding newBuilding= new NewBuilding();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController buildingNameController = new TextEditingController();
  final TextEditingController unitsController = new TextEditingController();
  final TextEditingController addressController = new TextEditingController();

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
      print('Form save called, newBuildingis now up to date...');
      print('Building Name: ${newBuilding.buildingName}');
      print('========================================');
      var userService = new NewBuildingService();
      userService.createBuilding(newBuilding)
          .then((value) =>
          showMessage('New building created ${value.buildingName}!', Colors.blue)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final buildingName = TextFormField(
      autofocus: false,
      validator: (value) =>
      value.isEmpty ? 'Please enter the building name' : null,
      onSaved: (value) => newBuilding.buildingName = value,
      controller: buildingNameController,
      decoration: InputDecoration(
        hintText: 'Building Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        fillColor: Colors.white,
        filled: true
      ),
    );

    final units = TextFormField(
      autofocus: false,
      validator: (value) =>
      value.isEmpty ? 'Please enter the number of units' : null,
      onSaved: (value) => newBuilding.units = int.parse(value),
      controller: unitsController,
      decoration: InputDecoration(
        hintText: 'Number of Units',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        fillColor: Colors.white,
        filled: true
      ),
    );

    final address = TextFormField(
      autofocus: false,
      validator: (value) =>
      value.isEmpty ? 'Please enter the building address' : null,
      onSaved: (value) => newBuilding.address = value,
      controller: addressController,
      decoration: InputDecoration(
        hintText: 'Address',
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
            buildingNameController.clear();
            unitsController.clear();
            addressController.clear();
          },
          color: Theme.of(context).accentColor,
          child: Text(
            'Add New Building',
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
        title: new Text("New Building"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              buildingName,
              units,
              address,
              SizedBox(height: 14.0),
              register
            ],
          ),
        ),
      ),
    );
  }
}
