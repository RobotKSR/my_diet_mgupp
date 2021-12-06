import 'package:flutter/material.dart';
import 'package:yourdiet/api_sheets/recipes_sheets_api.dart';
import 'package:yourdiet/api_sheets/user_sheets_api.dart';
import 'package:yourdiet/elements/recipe_card.dart';
import 'package:yourdiet/model/recipe.dart';
import 'package:yourdiet/model/user.dart';
import 'dart:developer';
import '../elements/list_gap.dart';
import '../elements/calculation_card.dart';
import '../elements/weight_status.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeBookScreen extends StatefulWidget {
  const RecipeBookScreen({Key? key}) : super(key: key);

  @override
  _RecipeBookScreen createState() => _RecipeBookScreen();
}

class _RecipeBookScreen extends State<RecipeBookScreen> {

  List<Recipe> recipes = [];
  List mealType = [[], [], []];
  List mealTypes = ['Для завтрака', 'На обед', 'К ужину'];

  bool loaded = false;

  @override
  void initState() {
    super.initState();
    getAllRecipes();
  }

  void getAllRecipes() async{
    recipes = await RecipeSheetsAPI.getAll();
    setByMealTypes();
  }

  void setByMealTypes() {
    for (int i = 0; i < 3; i++) {
        var recipe = recipes.where((element) => (
            element.breakfast == (i==0) &&
                element.dinner == (i==1) &&
                element.supper == (i==2)
        ));
        setState(() {
          mealType[i].addAll(recipe);
        });
    }

    loaded = true;
  }

  @override
  Widget build(BuildContext context) {

    void _handleRecipePress(Recipe recipe){
      Navigator.pushNamed(context, '/tutorial',
          arguments: {'recipe': recipe}
      );
    }

    if(!loaded){
      return  Container(
          color: Colors.grey.shade100,
          alignment: Alignment.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
      );
    }else {
      return  Container(
          color: Colors.grey.shade100,
          child: ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: mealType.length,
            itemBuilder: (context, i) =>
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(17, 10, 0, 5),
                      child: Text(
                        mealTypes[i],
                        style: TextStyle(fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter'),
                      ),
                    ),
                    SizedBox(
                      height: 285.0,
                      child: ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: mealType[i].length,
                          itemBuilder: (context, j) =>
                              recipeCard(
                                recipe: mealType[i][j],
                                onChanged: _handleRecipePress,
                              )
                      ),
                    ),

                  ],
                ),
          )
      );
    }
  }
}