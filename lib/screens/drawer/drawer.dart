import 'package:flutter/material.dart';
import 'package:navigation_bar/screens/bottomTabBar/FabTabsBar.dart';
import 'package:navigation_bar/screens/drawer/theme_provider.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatefulWidget {
  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blueGrey,
      child: ListView(
        padding: const EdgeInsets.only(top: 50.0),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 70),
                height: 70,
                width: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/profile.jpg'),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ],
          ),
          const Center(
            child: Text(
              "Madman Tumultous",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          Center(
            child: Text(
              "info@madman.dev",
              style: TextStyle(
                color: Colors.grey[200],
                fontSize: 15,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_filled),
            title: Text("Home"),
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FabBar(selectedIndex: 0)))
            },
          ),
          ListTile(
            leading: Icon(Icons.calculate_outlined),
            title: Text("Calculator"),
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FabBar(selectedIndex: 1)))
            },
          ),
          ListTile(
            leading: Icon(Icons.wifi_outlined),
            title: Text("Wifi"),
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FabBar(selectedIndex: 2)))
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text("Help"),
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FabBar(selectedIndex: 3)))
            },
          ),

          // DropdownButton as a trailing widget to enable Theme Mode(Light, Dark or System)
          Consumer<ThemeProvider>(
            builder: (context, provider, child) {
              return ListTile(
                leading: Icon(Icons.nights_stay_rounded),
                title: Text(
                  'Theme:',
                  style: Theme.of(context).textTheme.headline6,
                ),
                trailing: DropdownButton<String>(
                  value: provider.currentTheme,
                  icon: Icon(Icons.arrow_drop_down_circle_rounded),
                  underline: Container(),
                  onChanged: (String? value) {
                    provider.changeTheme(value ?? 'system');
                  },
                  items: [
                    DropdownMenuItem<String>(
                      value: 'light',
                      child: Row(
                        children: [
                          Icon(Icons.wb_sunny),
                          SizedBox(width: 5),
                          Text(
                            'Light',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem<String>(
                      value: 'dark',
                      child: Row(
                        children: [
                          const Icon(Icons.nightlight_round),
                          SizedBox(width: 5),
                          Text(
                            'Dark',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem<String>(
                      value: 'system',
                      child: Row(
                        children: [
                          Icon(Icons.settings),
                          SizedBox(width: 5),
                          Text(
                            'System',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
