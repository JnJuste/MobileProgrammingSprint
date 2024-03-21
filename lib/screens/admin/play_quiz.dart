import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:navigation_bar/models/question_model.dart';
import 'package:navigation_bar/services/database.dart';
import 'package:navigation_bar/views/quiz_play_widget.dart';
import 'package:navigation_bar/views/widgets.dart';
import 'package:overlay_support/overlay_support.dart';

class PlayQuiz extends StatefulWidget {
  final String quizId;
  const PlayQuiz({super.key, required this.quizId});

  @override
  State<PlayQuiz> createState() => _PlayQuizState();
}

int total = 0;
int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;

class _PlayQuizState extends State<PlayQuiz> {
  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot <Object?>? questionsSnapshot;
  

  @override
  void initState() {
    super.initState();
    databaseService = DatabaseService();
    databaseService.getQuizData(widget.quizId).then((value) async {
      final snapshot = await value as QuerySnapshot<Object?>;
      
      setState(() {
        questionsSnapshot = snapshot;
      _notAttempted = 0;
      _correct = 0;
      _incorrect = 0;
      total = questionsSnapshot!.docs.length;
      print("$total This is the total");
      });
    });
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

  QuestionModel getQuestionModelFromDataSnapshot(DocumentSnapshot questionSnapshot) {
  QuestionModel questionModel = new QuestionModel();

  if (questionSnapshot.data != null) {
    Map<String, dynamic> data = questionSnapshot.data() as Map<String, dynamic>;
    questionModel.question = data["question"];

    /// shuffling the options
    List<String> options = [
      data["option1"],
      data["option2"],
      data["option3"],
      data["option4"]
    ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = options[0]; // Set the correct option to the first shuffled option

    questionModel.answered = false;

    print(questionModel.correctOption.toLowerCase());
  }

  return questionModel;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Container(
        child: Column(
          children: [
            questionsSnapshot?.docs == null
                ? Container()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: questionsSnapshot?.docs.length,
                    itemBuilder: (context, index) {
                      return QuizPlayTile(
                        questionModel: getQuestionModelFromDataSnapshot(
                            questionsSnapshot!.docs[index]),
                        index: index,
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  const QuizPlayTile(
      {super.key, required this.questionModel, required this.index});

  @override
  State<QuizPlayTile> createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(widget.questionModel.question),
          const SizedBox(height: 4),
          OptionTile(
              correctAnswer: widget.questionModel.option1,
              description: widget.questionModel.option1,
              option: "A",
              optionSelected: optionSelected),
          const SizedBox(height: 4),
          OptionTile(
              correctAnswer: widget.questionModel.option1,
              description: widget.questionModel.option2,
              option: "B",
              optionSelected: optionSelected),
          const SizedBox(height: 4),
          OptionTile(
              correctAnswer: widget.questionModel.option1,
              description: widget.questionModel.option3,
              option: "C",
              optionSelected: optionSelected),
          const SizedBox(height: 4),
          OptionTile(
              correctAnswer: widget.questionModel.option1,
              description: widget.questionModel.option4,
              option: "D",
              optionSelected: optionSelected),
        ],
      ),
    );
  }
}

