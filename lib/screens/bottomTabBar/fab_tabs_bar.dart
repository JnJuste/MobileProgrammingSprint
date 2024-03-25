import 'package:flutter/material.dart';
import 'package:navigation_bar/screens/admin/create_quiz.dart';
import 'package:navigation_bar/screens/geolocation/geolocation.dart';
import 'package:navigation_bar/screens/calculator/calculator.dart';
import 'package:navigation_bar/screens/contact/contact.dart';
import 'package:navigation_bar/screens/admin/admin_dashboard.dart';

class FabBar extends StatefulWidget {
  final int selectedIndex;

  const FabBar({super.key, required this.selectedIndex});

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
        children: const [
          AdminDashboard(),
          GeoLocation(),
          Calculator(),
          ContactPage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateQuiz()));
        },
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 3, color: Colors.orange),
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
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
                icon: Icon(Icons.location_on_outlined,
                    color: currentIndex == 1 ? Colors.blueAccent : Colors.grey),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 2;
                  });
                },
                icon: Icon(Icons.calculate_outlined,
                    color:
                        currentIndex == 2 ? Colors.orangeAccent : Colors.grey),
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
