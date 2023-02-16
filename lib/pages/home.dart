import 'dart:async';
import 'dart:convert';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:gpt_recipes/Global.dart';
import 'package:gpt_recipes/components/roundedButton.dart';
import 'package:gpt_recipes/providers/recipe_provider.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PageHome> {
  String valueInput = "";
  bool loading = false;
  dynamic recipe;
  late OpenAI openAI;

  @override
  void initState() {
    // TODO: implement initState
    openAI = OpenAI.instance.build(
        token: Global.token,
        baseOption: HttpSetup(receiveTimeout: 60000),
        isLogger: true);
    super.initState();
  }

  void changeLoading(value) {
    setState(() {
      loading = value;
    });
  }

  Future<void> sendRequestGTP() async {
    try {
      //split string
      var values = valueInput.split(',');
      if (values.length < 3) {
        Alert(
                type: AlertType.warning,
                context: context,
                title: Global.languages[recipe.language]
                    ['alertTitleValidation'],
                desc: Global.languages[recipe.language]['alertDescriptionVal'])
            .show();
        return;
      }
      changeLoading(true);
      final request = CompleteText(
          prompt: Global.languages[recipe.language]['prompt']
              .replaceAll("{value}", valueInput),
          model: kTranslateModelV3,
          maxTokens: 800,
          temperature: 0.5);
      dynamic data = await openAI.onCompleteText(request: request);
      dynamic response = jsonDecode(data!.choices[0].text);
      print(response);
      changeLoading(false);
      recipe.recipeMode = response;
      Navigator.of(context).pushNamed('/recipe');
    } catch (e) {
      Alert(
              type: AlertType.error,
              context: context,
              title: Global.languages[recipe.language]['alertErrorTitle'],
              desc: Global.languages[recipe.language]['alertErrorDes'])
          .show();
      changeLoading(false);
      // TODO: handle exception, for example by showing an alert to the user
    }
  }

  @override
  void dispose() {
    ///close stream complete text
    openAI.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    recipe = Provider.of<RecipeProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/ingredients.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 30, right: 30, left: 30),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      Global.languages[recipe.language]['titleHome'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: TextFormField(
                        enabled: !loading,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          hintText: Global.languages[recipe.language]
                                  ['exampleHome'] ??
                              "",
                        ),
                        onChanged: (value) async {
                          setState(() {
                            valueInput = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(bottom: 20, top: 8),
                      child: Text(
                        Global.languages[recipe.language]['helpHome'],
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: RoundedButton(
                        buttonName: Global.languages[recipe.language]
                            ['buttonHome'],
                        onTap: sendRequestGTP,
                        width: 200,
                        height: 50.0,
                        borderWidth: 0.0,
                        buttonColor: Colors.blue,
                        textColor: Colors.white,
                        loading: loading,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: DropdownButton(
                          value: recipe.language,
                          onChanged: (dynamic val) {
                            recipe.setLanguage = val;
                          },
                          items: [
                            {'label': "English", "value": "en"},
                            {'label': "Spanish", "value": "es"}
                          ]
                              .map((e) => DropdownMenuItem(
                                    value: e['value'],
                                    child: Text(e['label'] ?? ""),
                                  ))
                              .toList()),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
