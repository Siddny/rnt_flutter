import 'package:flutter/material.dart';

import 'screens/houses/houses.dart';
import 'screens/tenants/tenants.dart';
import 'screens/buildings/building.dart';
import 'screens/payments/payments.dart';
// import 'screens/reports/reports.dart';
import 'screens/home/home.dart';

final routes= {
  '/': (BuildContext context) => new HomeScreen(),
  '/home': (BuildContext context) => new HomeScreen(),
  '/tenants': (BuildContext context) => new TenantState(),
  '/houses': (BuildContext context) => new HouseState(),
  '/buildings': (BuildContext context) => new BuildingState(),
  '/payments': (BuildContext context) => new PaymentState(),
//  '/reports': (BuildContext context) => new ReportsScreen(),
};