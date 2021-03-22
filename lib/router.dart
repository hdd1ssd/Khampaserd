import 'package:appforu/home.dart';
import 'package:appforu/screens/login.dart';
import 'package:appforu/screens/register.dart';
import 'package:flutter/material.dart';

  final Map<String, WidgetBuilder> routes = {
    '/home' : (BuildContext context) => Home(),
    '/login' : (BuildContext context) => Login(),
    '/register' : (BuildContext context) => Register(),
  };