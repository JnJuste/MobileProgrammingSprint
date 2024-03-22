import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:navigation_bar/views/widgets.dart';
import 'package:overlay_support/overlay_support.dart';

class Results extends StatefulWidget {
  final int total, correct, inCorrect, notattempted;
  Results(
      {required this.inCorrect,
      required this.total,
      required this.correct,
      required this.notattempted});

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  //Internet Connectivity
  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${widget.correct}/${widget.total}",
                style: const TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 8),
              Text(
                "You answered ${widget.correct} answers correctly"
                " and ${widget.inCorrect} answers incorrectly.",
                style: const TextStyle(fontSize: 15, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 14),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: blueButton(
                    context: context,
                    label: "Go Home",
                    buttonWidth: MediaQuery.of(context).size.width / 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
