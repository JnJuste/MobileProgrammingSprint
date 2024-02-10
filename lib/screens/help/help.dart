import 'package:flutter/material.dart';
import 'package:navigation_bar/screens/drawer/sideMenu.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text("Help"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'HELP',
              style: TextStyle(fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
