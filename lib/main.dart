import 'package:flutter/material.dart';
import 'package:gpt_recipes/providers/recipe_provider.dart';
import 'package:gpt_recipes/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RecipeProvider>(
            create: (context) => RecipeProvider()),
      ],
      child: MaterialApp(
        title: 'AI Recipes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        onGenerateRoute: (RouteSettings settings) {
          return getPageRoute(settings);
        },
      ),
    );
  }
}
