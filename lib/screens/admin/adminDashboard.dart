import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navigation_bar/screens/drawer/drawer.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text("Admin Dashboard"),
      ),
      body: ListView.builder(
        itemCount: 50,
        itemBuilder: (contex, index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.question_answer),
              title: const Text("Title"),
              subtitle: const Text("Title"),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialogBox,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  _showDialogBox() {
    Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 15),
      contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      title: "Add Quiz",
      content: Column(
        children: [
          TextFormField(
            decoration:
                const InputDecoration(hintText: "Enter the Category Name"),
          ),
          TextFormField(
            decoration:
                const InputDecoration(hintText: "Enter the Category Subtitle"),
          ),
        ],
      ),
      textConfirm: "Create",
      textCancel: "Cancel",
      onConfirm: () {
        print("Question Set has been created");
      },
    );
  }
}
