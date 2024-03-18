import 'package:flutter/material.dart';
import 'package:navigation_bar/screens/drawer/drawer.dart';

class Wifi extends StatefulWidget {
  const Wifi({Key? key}) : super(key: key);

  @override
  State<Wifi> createState() => _AboutState();
}

class _AboutState extends State<Wifi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Geo Location"),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
