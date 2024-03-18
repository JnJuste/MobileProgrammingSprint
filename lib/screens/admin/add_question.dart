import 'package:flutter/material.dart';
import 'package:navigation_bar/services/database.dart';
import 'package:navigation_bar/views/widgets.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;
  const AddQuestion({super.key, required this.quizId});

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  String question = "", option1 = "", option2 = "", option3 = "", option4 = "";
  bool _isLoading = false;
  DatabaseService databaseService = new DatabaseService();

  uploadQuestionData() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      Map<String, String> questionMap = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4,
      };

      print("${widget.quizId}");
      await databaseService
          .addQuestionData(questionMap, widget.quizId)
          .then((value) {
        question = "";
        option1 = "";
        option2 = "";
        option3 = "";
        option4 = "";
        setState(() {
          _isLoading = false;
        });
      }).catchError((e) {
        print(e);
      });
    } else {
      print("error is happening");
    }
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
      body: _isLoading
          ? Container(
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Enter Question" : null,
                      decoration: const InputDecoration(hintText: "Question"),
                      onChanged: (val) {
                        //To Do
                        question = val;
                      },
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Enter Option 1" : null,
                      decoration: const InputDecoration(
                          hintText: "Option 1 (Correct Answer)"),
                      onChanged: (val) {
                        //To Do
                        option1 = val;
                      },
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Enter Option 2" : null,
                      decoration: const InputDecoration(hintText: "Option 2"),
                      onChanged: (val) {
                        //To Do
                        option2 = val;
                      },
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Enter Option 3" : null,
                      decoration: const InputDecoration(hintText: "Option 3"),
                      onChanged: (val) {
                        //To Do
                        option3 = val;
                      },
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Enter Option 4" : null,
                      decoration: const InputDecoration(hintText: "Option 4"),
                      onChanged: (val) {
                        //To Do
                        option4 = val;
                      },
                    ),
                    const SizedBox(height: 24), // Adjusted height
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: blueButton(
                              context: context,
                              label: "Submit",
                              buttonWidth:
                                  MediaQuery.of(context).size.width / 2 - 36),
                        ),
                        const SizedBox(width: 24),
                        GestureDetector(
                          onTap: () async {
                            if (widget.quizId.isNotEmpty) {
                              await uploadQuestionData();
                            } else {
                              print(
                                  "Quiz ID is empty, cannot add question data.");
                            }
                          },
                          child: blueButton(
                            context: context,
                            label: "Add Question",
                            buttonWidth:
                                MediaQuery.of(context).size.width / 2 - 36,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
