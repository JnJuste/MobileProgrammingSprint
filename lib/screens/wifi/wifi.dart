import 'package:flutter/material.dart';
import 'package:navigation_bar/screens/drawer/sideMenu.dart';

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
        title: Text("Wifi"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'WIFI',
              style: TextStyle(fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
