import 'package:flutter/material.dart';
import 'package:navigation_bar/screens/drawer/drawer.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _HelpState();
}

class _HelpState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text("Contact"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'CONTACT',
              style: TextStyle(fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
