import 'package:flutter/material.dart';
import 'routes.dart';

void main() => runApp(new RentalApp());

class RentalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Rental Management',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      routes: routes,
    );
  }
}
