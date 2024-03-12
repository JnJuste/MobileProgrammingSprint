import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navigation_bar/models/questionModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionController extends GetxController {
  final List<Question> _questions = [];
  List<Question> get questions => _questions;

  //Admin Dashboard
  final String _categoryKey = "category_title";
  final String _subtitleKey = "subtitle";
  TextEditingController categoryTitleController = TextEditingController();
  TextEditingController categorySubTitleController = TextEditingController();

  RxList<String> savedCategories = <String>[].obs;
  RxList<String> savedSubtitle = <String>[].obs;

  void savedQuestionCategoryToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    savedCategories.add(categoryTitleController.text);
    savedSubtitle.add(categorySubTitleController.text);
    await prefs.setStringList(_categoryKey, savedCategories);
    await prefs.setStringList(_subtitleKey, savedSubtitle);

    categoryTitleController.clear();
    categorySubTitleController.clear();
    Get.snackbar("Saved", "Category created successfully");
  }
}
