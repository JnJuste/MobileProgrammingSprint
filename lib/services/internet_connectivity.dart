import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';

class Internet {
  bool connected = false;
  checkInternetConn() async {
    connected = await InternetConnectionChecker().hasConnection;
    final message =
        connected ? "CONNECTED TO INTERNET" : "NOT CONNECTED TO INTERNET";
    showSimpleNotification(Text('$message'));
  }
}
