import 'package:flutter/material.dart';
import 'package:navigation_bar/screens/wifi/wifi.dart';
import 'package:navigation_bar/screens/calculator/calculator.dart';
import 'package:navigation_bar/screens/contact/contact.dart';
import 'package:navigation_bar/screens/admin/adminDashboard.dart';

class FabBar extends StatefulWidget {
  final int selectedIndex;

  const FabBar({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  _FabBarState createState() => _FabBarState();
}

class _FabBarState extends State<FabBar> {
  late int currentIndex;

  @override
  void initState() {
    currentIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          const AdminDashboard(),
          const Calculator(),
          const Wifi(),
          const ContactPage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
        onPressed: () => debugPrint("Add Button Pressed"),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 3, color: Colors.orange),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 0;
                  });
                },
                icon: Icon(Icons.dashboard,
                    color: currentIndex == 0 ? Colors.pinkAccent : Colors.grey),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 1;
                  });
                },
                icon: Icon(Icons.calculate,
                    color: currentIndex == 1
                        ? Colors.deepOrangeAccent
                        : Colors.grey),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 2;
                  });
                },
                icon: Icon(Icons.wifi_outlined,
                    color: currentIndex == 2 ? Colors.blueAccent : Colors.grey),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 3;
                  });
                },
                icon: Icon(Icons.contact_page_outlined,
                    color:
                        currentIndex == 3 ? Colors.greenAccent : Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
