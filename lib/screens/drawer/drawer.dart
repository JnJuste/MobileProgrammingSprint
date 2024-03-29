import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:navigation_bar/screens/bottomTabBar/fab_tabs_bar.dart';
import 'package:navigation_bar/screens/drawer/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SideMenu extends StatefulWidget {
  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final user = FirebaseAuth.instance.currentUser;

  // Google Sign Out
  signUserOut() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      GoogleSignIn googleSignIn = GoogleSignIn();

      // Sign out from Firebase
      await auth.signOut();

      // Disconnect Google Sign In
      await googleSignIn.disconnect();
    } catch (e) {
      print("Error during sign out: $e");
    }
  }

  Uint8List? _image;
  File? selectedIMage;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blueGrey,
      child: ListView(
        padding: const EdgeInsets.only(top: 70.0),
        children: [
          // Image & Gallery Access
          Center(
            child: Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 80, backgroundImage: MemoryImage(_image!))
                    : const CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(
                            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
                      ),
                Positioned(
                    bottom: 0,
                    left: 100,
                    child: IconButton(
                        onPressed: () {
                          showImagePickerOption(context);
                        },
                        icon: const Icon(Icons.add_a_photo)))
              ],
            ),
          ),

          // For Username show Up
          Center(
            child: Text(
              "${user!.displayName}",
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),

          const SizedBox(height: 15),
          // Email Show up
          Center(
            child: Text(
              user!.email!,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),

          //Sign Out
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text("Dashboard"),
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FabBar(selectedIndex: 0)))
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on_outlined),
            title: const Text("Geo Location"),
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FabBar(selectedIndex: 1)))
            },
          ),
          ListTile(
            leading: const Icon(Icons.calculate_outlined),
            title: const Text("Calculator"),
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FabBar(selectedIndex: 2)))
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_page_outlined),
            title: const Text("Contact"),
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FabBar(selectedIndex: 3)))
            },
          ),

          // Sign Out ListTile
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              // Call the signUserOut method when tapped
              signUserOut();
              // Optionally, navigate to login or wherever after signing out
            },
          ),

          // DropdownButton as a trailing widget to enable Theme Mode(Light, Dark or System)
          Consumer<ThemeProvider>(
            builder: (context, provider, child) {
              return ListTile(
                leading: const Icon(Icons.nights_stay_rounded),
                title: Text(
                  'Theme:',
                  style: Theme.of(context).textTheme.headline6,
                ),
                trailing: DropdownButton<String>(
                  value: provider.currentTheme,
                  icon: const Icon(Icons.arrow_drop_down_circle_rounded),
                  underline: Container(),
                  onChanged: (String? value) {
                    provider.changeTheme(value ?? 'system');
                  },
                  items: [
                    DropdownMenuItem<String>(
                      value: 'light',
                      child: Row(
                        children: [
                          const Icon(Icons.wb_sunny),
                          const SizedBox(width: 5),
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
                          const SizedBox(width: 5),
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
                          const Icon(Icons.settings),
                          const SizedBox(width: 5),
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

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.blue[100],
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4.5,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromGallery();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 50,
                            ),
                            Text("Gallery")
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromCamera();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 50,
                            ),
                            Text("Camera")
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  //Gallery
  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop(); //close the model sheet
  }

  //Camera
  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }
}
