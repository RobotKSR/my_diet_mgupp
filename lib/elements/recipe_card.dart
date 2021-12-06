import 'package:flutter/material.dart';
import 'package:yourdiet/elements/little_recipe_info.dart';
import 'package:yourdiet/model/recipe.dart';

class recipeCard extends StatefulWidget {
 const recipeCard({
  Key? key,
  required this.recipe,
  required this.onChanged,
 }) : super(key: key);

 final Recipe recipe;
 final ValueChanged<Recipe> onChanged;

 @override
 _recipeCardState createState() => _recipeCardState();
}

class _recipeCardState extends State<recipeCard> {
 String gender = 'female';
 String genderRus = 'Женщина';

 void _handlePress() {
  widget.onChanged(widget.recipe);
 }

 @override
 Widget build(BuildContext context) {
  String mealTime = '';

  if (widget.recipe.breakfast) {
   mealTime = 'Завтрак';
  }
  if (widget.recipe.dinner) {
   mealTime = 'Обед';
  }
  if (widget.recipe.supper) {
   mealTime = 'Ужин';
  }

  return Card(
   shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
   ),
   clipBehavior: Clip.antiAlias,
   child: SizedBox(
    width: 300,
    child: MaterialButton(
     onPressed: _handlePress,
     padding: EdgeInsets.all(0),
     child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Image.network(
          widget.recipe.picture,
          height: 180,
          width: 300,
          fit: BoxFit.cover,
         ),
         Flexible(
          child: Padding(
           padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Text(mealTime,
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 12, fontFamily: 'Roboto'),
               ),
               Text(widget.recipe.minutes.toString() + ' мин.',
                textAlign: TextAlign.end,
                style: const TextStyle(fontSize: 12, fontFamily: 'Roboto'),
               ),
              ],
             ),
             Text(widget.recipe.title,
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto'),
             ),
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 4.5),
              child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                littleRecipeInfo(widget.recipe.calories.toString() + ' Ккал', 'Калории', Colors.cyan.shade100),
                littleRecipeInfo(widget.recipe.fats.toString() + ' г', 'Жиры', Colors.yellow.shade200),
                littleRecipeInfo(widget.recipe.carbs.toString() + ' г', 'Углеводы', Colors.red.shade100),
                littleRecipeInfo(widget.recipe.proteins.toString() + ' г', 'Белки', Colors.greenAccent.shade100),
               ],
              ),
             ),
            ],
           ),
          ),
         ),
        ]
    ),
   ),
      )
  );
 }
}