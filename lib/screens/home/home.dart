import 'package:flutter/material.dart';
import 'package:navigation_bar/screens/drawer/drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text("Home"),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'HOME',
              style: TextStyle(fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
