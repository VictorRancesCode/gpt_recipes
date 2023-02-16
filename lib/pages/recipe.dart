import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:gpt_recipes/Global.dart';
import 'package:gpt_recipes/providers/recipe_provider.dart';
import 'package:provider/provider.dart';

class PageRecipe extends StatefulWidget {
  const PageRecipe({Key? key}) : super(key: key);

  @override
  PageRecipeState createState() => PageRecipeState();
}

class PageRecipeState extends State<PageRecipe> {
  late OpenAI openAI;
  String? image;
  dynamic recipe;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recipe = Provider.of<RecipeProvider>(context, listen: false);
    openAI = OpenAI.instance.build(
        token: Global.token,
        baseOption: HttpSetup(receiveTimeout: 7000),
        isLogger: true);
    generateImageRecipe();
  }

  @override
  void dispose() {
    ///close stream complete text
    openAI.close();
    super.dispose();
  }

  void generateImageRecipe() async {
    final request = GenerateImage(recipe.recipeMode['image'], 1);
    final response = await openAI.generateImage(request);
    setState(() {
      image = response?.data?.last?.url;
    });
  }

  List<Widget> getIngredients() {
    List<Widget> ingredients = [];
    for (final ingredient in recipe.recipeMode["ingredients"]) {
      ingredients.add(Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Text(ingredient),
      ));
    }
    return ingredients;
  }

  List<Widget> getInstructions() {
    List<Widget> instructions = [];
    for (final instruction in recipe.recipeMode["instructions"]) {
      instructions.add(Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Text(instruction),
      ));
    }
    return instructions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(recipe.recipeMode["name"]),
              centerTitle: false,
              expandedTitleScale: 1,
              background: Image.network(
                image != null
                    ? image!
                    : "https://cdn.pixabay.com/photo/2019/12/14/07/21/mountain-4694346_960_720.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      Global.languages[recipe.language]['ingredients'],
                      style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  ...getIngredients(),
                  Container(
                    padding: const EdgeInsets.only(bottom: 15, top: 20),
                    child: Text(
                      Global.languages[recipe.language]['instructions'],
                      style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  ...getInstructions(),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
