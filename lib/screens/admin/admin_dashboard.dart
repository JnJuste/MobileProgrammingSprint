import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:navigation_bar/screens/admin/play_quiz.dart';
import 'package:navigation_bar/screens/drawer/drawer.dart';
import 'package:navigation_bar/services/database.dart';
import 'package:overlay_support/overlay_support.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
//Internet Connectivity
  @override
  void initState() {
    databaseService.getQuizzesData().then((val) {
      setState(() {
        quizStream = val;
      });
    });
    quizStream = const Stream.empty();
    super.initState();

    InternetConnectionChecker().onStatusChange.listen((status) {
      final connected = status == InternetConnectionStatus.connected;
      showSimpleNotification(
          Text(
            connected ? "CONNECTED TO INTERNET!" : "NO INTERNET!",
            textAlign: TextAlign.center,
          ),
          background: connected ? Colors.green : Colors.red);
    });
  }

  Stream<dynamic>? quizStream;
  DatabaseService databaseService = new DatabaseService();

  Widget quizList() {
    return Container(
      child: StreamBuilder(
        stream: quizStream,
        builder: (context, snapshot) {
          return snapshot.data == null
              ? Container()
              : ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return QuizTile(
                      imageUrl: snapshot.data.docs[index]["quizImgUrl"],
                      desc: snapshot.data.docs[index]["quizDesc"],
                      title: snapshot.data.docs[index]["quizTitle"],
                      quizid: snapshot.data.docs[index]["quizId"],
                    );
                  },
                );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.pinkAccent,
      ),
      body: quizList(),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String desc;
  final String quizid;

  const QuizTile({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.desc,
    required this.quizid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PlayQuiz(quizId: quizid)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        height: 150,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black26,
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    desc,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
