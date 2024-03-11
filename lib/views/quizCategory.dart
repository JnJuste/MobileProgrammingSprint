import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuizCategoryScreen extends StatelessWidget {
  const QuizCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset("assets/bg.svg"),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: 50,
            itemBuilder: (context, index) {
              return Card(
                child: GestureDetector(
                  onTap: () {},
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.question_answer),
                      Text("Quiz Title"),
                      Text("Quiz Subtitle")
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
