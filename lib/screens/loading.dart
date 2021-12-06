import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:yourdiet/api_sheets/recipes_sheets_api.dart';
import 'package:yourdiet/api_sheets/user_sheets_api.dart';
import 'package:yourdiet/elements/app_topbar.dart';
import 'package:yourdiet/elements/list_gap.dart';
import 'package:yourdiet/model/recipe.dart';
import 'package:yourdiet/model/user.dart';
import '../elements/activity_card.dart';
import '../elements/big_text.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreen createState() => _LoadingScreen();
}

class _LoadingScreen extends State<LoadingScreen> {

  List<Recipe> recipes = [];
  List daily = [[], [], [], [], [], [], []];
  var user;

  @override
  void initState() {
    super.initState();
    /*Future.delayed(
        const Duration(seconds: 3),
            () =>
                Navigator.pushNamed(context, '/menu', arguments: {'user': user, 'daily': daily})
    );*/
  }

  Recipe getSuitableRecipe(bool breakfast, bool dinner, bool supper, User user) {
    var vegeterian = user.foodType == 'vegeterian' ? true : false;

    //helper if suitable recipe not found at the moment
    var rsupply = recipes.where((element) => (
        element.breakfast == breakfast &&
            element.dinner == dinner &&
            element.supper == supper));
    if(vegeterian){
      rsupply = rsupply.where((element) => (element.vegeterian == vegeterian));
    }

    var r = recipes.where((element) => (
        element.breakfast == breakfast &&
            element.dinner == dinner &&
            element.supper == supper) &&
        //element.calories < user.calories/2.9 &&
        ((element.magnesium && user.magnesium) ||
            (element.sulfur && user.sulfur) ||
            (element.protein && user.protein) ||
            (element.silicon && user.silicon) ||
            (element.netrogen && user.netrogen) ||
            (element.chlorine && user.chlorine) ||
            (element.calcium && user.calcium) ||
            (element.manganese && user.manganese) ||
            (element.water && user.water) ||
            (element.iron && user.iron) ||
            (element.carbon && user.carbon)) );

    if(vegeterian){
      r = r.where((element) => (element.vegeterian == vegeterian));
    }
    if(r.length > 1) {
      return r.elementAt(Random().nextInt(r.length - 1));
    }else if (r.length == 1){
      return r.first;
    }

    return rsupply.first;
  }

  void saveDaily() async{
    final prefs = await SharedPreferences.getInstance();
    String jsonDaily = jsonEncode(daily);
    await prefs.setString('daily', jsonDaily);

    Navigator.pushNamed(context, '/navigation', arguments: {'user': user, 'daily': daily});
  }

  var recipe;
  void setDaily() {
    for (int i = 0; i < 7; i++){
      for (int j = 0; j < 3; j++) {
        recipe = getSuitableRecipe(j == 0, j == 1, j == 2, user);
        setState(() {
          daily[i].add(recipe);
        });
      }
    }
    saveDaily();
  }

  Future getRecipes() async {
    final recipes = await RecipeSheetsAPI.getAll();

    setState(() {
      this.recipes = recipes;
    });
    setDaily();
  }

  void updateUserSheet() async {
    final userInfo = await UserSheetsAPI.getById(user.id);
    if (userInfo == null) {
      await UserSheetsAPI.insert([user.toJson()]);
    } else {
      await UserSheetsAPI.update(user.id, user.toJson());
    }
    getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    if(user == null) {
      user = args['user'];
      dev.log('user and recipes loading');
      updateUserSheet();
    }

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          title: topBar(),
      ),
      body: Container(
          color: Colors.grey.shade100,
          alignment: Alignment.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               const Text('Формируем персональную диету...',
                textAlign: TextAlign.center,
                style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                  fontFamily: 'Inter'
                )
               ),
                listGap(),
                listGap(),
                SizedBox(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade400),
                    strokeWidth: 7.0,
                    backgroundColor: Colors.grey.shade300,
                  ),
                  height: 70.0,
                  width: 70.0,
                ),
              ]
          )
      ),
    );
  }
}