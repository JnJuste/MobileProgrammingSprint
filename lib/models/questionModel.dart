class Question {
  final int id;
  final String questions;
  final String category;
  final List<String> options;
  final int answer;

  Question({
    required this.id,
    required this.questions,
    required this.category,
    required this.options,
    required this.answer,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "questions": questions,
      "category": category,
      "options": options,
      "answer": answer
    };
  }

  //To return the existing instance
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json["id"],
      questions: json["questions"],
      category: json["category"],
      options: json["options"],
      answer: json["answer"],
    );
  }
}
