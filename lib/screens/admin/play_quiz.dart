import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:navigation_bar/models/question_model.dart';
import 'package:navigation_bar/screens/admin/results.dart';
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

/// Stream
Stream<dynamic>? infoStream;

class _PlayQuizState extends State<PlayQuiz> {
  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot<Object?>? questionsSnapshot;
  bool isLoading = true;

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
        isLoading = false;
        total = questionsSnapshot!.docs.length;

        print("init don $total ${widget.quizId} ");
      });
    });

    infoStream ??=
        Stream<List<int>>.periodic(const Duration(milliseconds: 10), (x) {
      print("this is x $x");
      return [_correct, _incorrect];
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

  QuestionModel getQuestionModelFromDataSnapshot(
      DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = new QuestionModel();

    Map<String, dynamic> data = questionSnapshot.data() as Map<String, dynamic>;
    questionModel.question = data["question"];

    // Shuffling the options of the question
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
    questionModel.correctOption =
        data["option1"]; /*Set the correct option to the first shuffled option*/

    questionModel.answered = false;

    print(questionModel.correctOption.toLowerCase());

    return questionModel;
  }

  @override
  void dispose() {
    infoStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        centerTitle: true,
        //backgroundColor: Colors.transparent,
        elevation: 0.0,
        //iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: isLoading
          ? Container(
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    InfoHeader(length: questionsSnapshot?.docs.length ?? 0),
                    const SizedBox(
                      height: 10,
                    ),
                    questionsSnapshot == null
                        ? Container(
                            child: const Center(child: Text("No Data")),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
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
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Results(
                correct: _correct,
                inCorrect: _incorrect,
                total: total,
                notattempted: _notAttempted,
              ),
            ),
          );
        },
      ),
    );
  }
}

class InfoHeader extends StatefulWidget {
  final int length;

  InfoHeader({required this.length});

  @override
  _InfoHeaderState createState() => _InfoHeaderState();
}

class _InfoHeaderState extends State<InfoHeader> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: infoStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? Container(
                height: 40,
                margin: const EdgeInsets.only(left: 14),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: <Widget>[
                    NoOfQuestionTile(
                      text: "Total",
                      number: widget.length,
                    ),
                    NoOfQuestionTile(
                      text: "Correct",
                      number: _correct,
                    ),
                    NoOfQuestionTile(
                      text: "Incorrect",
                      number: _incorrect,
                    ),
                    NoOfQuestionTile(
                      text: "Not Attempted",
                      number: _notAttempted,
                    ),
                  ],
                ),
              )
            : Container();
      },
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Q${widget.index + 1}. ${widget.questionModel.question}",
            style: const TextStyle(fontSize: 17, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option1 ==
                    widget.questionModel.correctOption) {
                  setState(() {
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: OptionTile(
              option: "A",
              description: "${widget.questionModel.option1}",
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option2 ==
                    widget.questionModel.correctOption) {
                  setState(() {
                    optionSelected = widget.questionModel.option2;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel.option2;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: OptionTile(
              option: "B",
              description: "${widget.questionModel.option2}",
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option3 ==
                    widget.questionModel.correctOption) {
                  setState(() {
                    optionSelected = widget.questionModel.option3;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel.option3;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: OptionTile(
              option: "C",
              description: "${widget.questionModel.option3}",
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option4 ==
                    widget.questionModel.correctOption) {
                  setState(() {
                    optionSelected = widget.questionModel.option4;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel.option4;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: OptionTile(
              option: "D",
              description: "${widget.questionModel.option4}",
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
