import 'package:flutter/material.dart';
import 'package:gpt_recipes/pages/home.dart';
import 'package:gpt_recipes/pages/recipe.dart';
import 'package:gpt_recipes/pages/splashscreen.dart';

getPageRoute(RouteSettings settings) {
  dynamic data = settings.arguments;
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => SplashScreen());
    case '/home':
      return MaterialPageRoute(builder: (_) => PageHome());
    case '/recipe':
      return MaterialPageRoute(builder: (_) => PageRecipe());
  }
}
