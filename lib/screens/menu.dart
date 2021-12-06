import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourdiet/elements/recipe_card.dart';
import 'package:yourdiet/model/recipe.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreen createState() => _MenuScreen();
}

class _MenuScreen extends State<MenuScreen> {

  String uid = '';
  List daily = [[], [], [], [], [], [], []];
  var user;
  bool loaded = false;

  @override
  void initState(){
    super.initState();

    loadInfo();
  }

  void loadInfo() async {
    final prefs = await SharedPreferences.getInstance();
    var dailyString;
    setState(() {
      uid = prefs.getString('uid') ?? 'none';
      dailyString = prefs.getString('daily') ?? 'none';
    });
    daily = jsonDecode(dailyString);

    setState(() {
      loaded = true;
    });
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
          itemCount: daily.length,
          itemBuilder: (context, i) =>
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(17, 10, 0, 5),
                    child: Text(
                      'День ' + (i + 1).toString(),
                      style: TextStyle(fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter'),
                    ),
                  ),
                  SizedBox(
                    height: 285.0,
                    child: ListView.builder(
                        padding: EdgeInsets.symmetric(
                            vertical: 0, horizontal: 5),
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: daily[i].length,
                        itemBuilder: (context, j) =>
                            recipeCard(
                                recipe: Recipe.fromJson(daily[i][j]),
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


/*
 return  Container(
          color: Colors.grey.shade100,
          child: ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: daily.length,
          itemBuilder: (context, i) =>
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(17, 10, 0, 5),
                    child: Text(
                      'День ' + (i + 1).toString(),
                      style: TextStyle(fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter'),
                    ),
                  ),
                  SizedBox(
                    height: 285.0,
                    child: ListView.builder(
                        padding: EdgeInsets.symmetric(
                            vertical: 0, horizontal: 5),
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: daily[i].length,
                        itemBuilder: (context, j) =>
                            recipeCard(
                                recipe: Recipe.fromJson(daily[i][j]),
                                onChanged: _handleRecipePress,
                            )
                    ),
                  ),

                ],
              ),
          )
      );
*/