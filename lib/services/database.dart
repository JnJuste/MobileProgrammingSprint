import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> addQuizData(Map<String, dynamic> quizData, String quizId) async {
    if (quizId.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection("Quiz")
          .doc(quizId)
          .set(quizData)
          .catchError((e) {
        print(e.toString());
      });
    } else {
      print("Quiz ID is empty, cannot add quiz data.");
    }
  }

  Future<void> addQuestionData(
      Map<String, dynamic> questionData, String quizId) async {
    if (quizId.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection("Quiz")
          .doc(quizId)
          .collection("QNA")
          .add(questionData)
          .catchError((e) {
        print("Error adding question data: $e");
      });
    } else {
      print("Quiz ID is empty, cannot add question data.");
    }
  }

  getQuizzesData() async {
    return await FirebaseFirestore.instance.collection("Quiz").snapshots();
  }

  getQuizData(String quizId) async {
    return await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QNA")
        .get();
  }
}
