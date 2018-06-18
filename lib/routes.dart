import 'package:flutter/material.dart';

import 'screens/houses/houses.dart';
import 'screens/tenants/tenants.dart';
import 'screens/payments/payments.dart';
import 'screens/reports/reports.dart';
import 'screens/home/home.dart';

final routes= {
  '/': (BuildContext context) => new HomeScreen(),
  '/home': (BuildContext context) => new HomeScreen(),
  '/tenants': (BuildContext context) => new TenantState(),
  '/houses': (BuildContext context) => new HouseState(),
//  '/payments': (BuildContext context) => new PaymentScreen(),
//  '/reports': (BuildContext context) => new ReportsScreen(),
};