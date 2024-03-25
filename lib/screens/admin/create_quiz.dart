import 'package:flutter/material.dart';
import 'package:navigation_bar/screens/admin/add_question.dart';
import 'package:navigation_bar/services/database.dart';
import 'package:navigation_bar/views/widgets.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({super.key});

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  late String quizImageUrl, quizTitle, quizDescription, quizId;
  DatabaseService databaseService = new DatabaseService();

  bool _isLoading = false;

  createQuizOnline() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);
      Map<String, String> quizMap = {
        "quizId": quizId,
        "quizImgUrl": quizImageUrl,
        "quizTitle": quizTitle,
        "quizDesc": quizDescription,
      };
      await databaseService.addQuizData(quizMap, quizId).then((value) {
        setState(() {
          _isLoading = false;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddQuestion(quizId: quizId),
            ),
          );
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        //iconTheme: const IconThemeData(color: Colors.black87),
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
                          val!.isEmpty ? "Enter Image URL" : null,
                      decoration:
                          const InputDecoration(hintText: "Quiz Image URL"),
                      onChanged: (val) {
                        //To Do
                        quizImageUrl = val;
                      },
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Enter Quiz Title" : null,
                      decoration: const InputDecoration(hintText: "Quiz Title"),
                      onChanged: (val) {
                        //To Do
                        quizTitle = val;
                      },
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Enter Quiz Description" : null,
                      decoration:
                          const InputDecoration(hintText: "Quiz Description"),
                      onChanged: (val) {
                        //To Do
                        quizDescription = val;
                      },
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        createQuizOnline();
                      },
                      child: blueButton(context: context, label: "Create Quiz"),
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
    );
  }
}
