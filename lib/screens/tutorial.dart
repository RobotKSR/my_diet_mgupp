import 'package:flutter/material.dart';
import 'package:yourdiet/api_sheets/recipes_sheets_api.dart';
import 'package:yourdiet/api_sheets/user_sheets_api.dart';
import 'package:yourdiet/elements/app_topbar.dart';
import 'package:yourdiet/elements/little_recipe_info.dart';
import 'package:yourdiet/elements/recipe_info.dart';
import 'package:yourdiet/model/user.dart';
import 'dart:developer';
import '../elements/list_gap.dart';
import '../elements/calculation_card.dart';
import '../elements/weight_status.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  _TutorialScreen createState() => _TutorialScreen();
}

class _TutorialScreen extends State<TutorialScreen> {

  String uid = '';
  var recipe;

  @override
  void initState() {
    super.initState();
    loadId();
  }

  void loadId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString('uid') ?? 'none';
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    recipe = args['recipe'];

    String mealTime = '';

    if (recipe.breakfast) {
      mealTime = 'Завтрак';
    }
    if (recipe.dinner) {
      mealTime = 'Обед';
    }
    if (recipe.supper) {
      mealTime = 'Ужин';
    }

    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          title: topBar(),
      ),
      body: Container(
          color: Colors.white,
          alignment: Alignment.bottomCenter,
          child: ListView(
              children: <Widget> [
                Image.network(
                  recipe.picture,
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(mealTime,
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontSize: 14, fontFamily: 'Roboto'),
                    ),
                    Text(recipe.minutes.toString() + ' мин.',
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontSize: 14, fontFamily: 'Roboto'),
                    ),
                  ],
                ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  child: Text(recipe.title,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Roboto',
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                  child: Text(recipe.description,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontFamily: 'Inter'
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      recipeInfo(recipe.calories.toString() + ' Ккал', 'Калории', Colors.cyan.shade100),
                      recipeInfo(recipe.fats.toString() + ' г', 'Жиры', Colors.yellow.shade200),
                      recipeInfo(recipe.carbs.toString() + ' г', 'Углеводы', Colors.red.shade100),
                      recipeInfo(recipe.proteins.toString() + ' г', 'Белки', Colors.greenAccent.shade100),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                  child: Text(recipe.tutorial,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontFamily: 'Inter'
                    ),
                  ),
                ),
                //bigText(args.toString()),
                listGap(),
                listGap()
              ]
          )
      ),
    );

  }
}