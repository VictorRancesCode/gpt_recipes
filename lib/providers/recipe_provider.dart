import 'package:flutter/material.dart';

class RecipeProvider extends ChangeNotifier {
  dynamic _data = {};
  String language = "en";

  dynamic get recipeMode => _data;

  set recipeMode(dynamic mode) {
    _data = mode;
    notifyListeners();
  }

  set setLanguage(String lg) {
    language = lg;
    notifyListeners();
  }
}
