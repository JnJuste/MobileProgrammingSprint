import 'package:flutter/material.dart';
import 'package:navigation_bar/screens/wifi/wifi.dart';
import 'package:navigation_bar/screens/calculator/calculator.dart';
import 'package:navigation_bar/screens/help/help.dart';
import 'package:navigation_bar/screens/home/home.dart';

// ignore: must_be_immutable
class FabBar extends StatefulWidget {
  int selectedIndex = 0;
  FabBar({required this.selectedIndex});

  @override
  State<FabBar> createState() => _FabBarState();
}

class _FabBarState extends State<FabBar> {
  int currentIndex = 0;

  void onButtonTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
      currentIndex = widget.selectedIndex;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    onButtonTapped(widget.selectedIndex);
    super.initState();
  }

  final List<Widget> pages = [
    Home(),
    Calculator(),
    Wifi(),
    Help(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    Widget currentScreen = currentIndex == 0
        ? Home()
        : currentIndex == 1
            ? Calculator()
            : currentIndex == 2
                ? Wifi()
                : Help();
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
        onPressed: () {
          print("Add Another Button");
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 90,
                    onPressed: () {
                      setState(() {
                        currentScreen = Home();
                        currentIndex = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_filled,
                          color: currentIndex == 0
                              ? Colors.pinkAccent
                              : Colors.grey,
                        ),
                        Text(
                          "Home",
                          style: TextStyle(
                              color: currentIndex == 0
                                  ? Colors.pinkAccent
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 90,
                    onPressed: () {
                      setState(() {
                        currentScreen = Calculator();
                        currentIndex = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calculate,
                          color: currentIndex == 1
                              ? Colors.deepOrangeAccent
                              : Colors.grey,
                        ),
                        Text(
                          "Calculator",
                          style: TextStyle(
                              color: currentIndex == 1
                                  ? Colors.deepOrangeAccent
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 90,
                    onPressed: () {
                      setState(() {
                        currentScreen = Wifi();
                        currentIndex = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.wifi_outlined,
                          color: currentIndex == 2
                              ? Colors.blueAccent
                              : Colors.grey,
                        ),
                        Text(
                          "Wifi",
                          style: TextStyle(
                              color: currentIndex == 2
                                  ? Colors.blueAccent
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 90,
                    onPressed: () {
                      setState(() {
                        currentScreen = Help();
                        currentIndex = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info,
                          color: currentIndex == 3
                              ? Colors.greenAccent
                              : Colors.grey,
                        ),
                        Text(
                          "Help",
                          style: TextStyle(
                              color: currentIndex == 3
                                  ? Colors.greenAccent
                                  : Colors.grey),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
