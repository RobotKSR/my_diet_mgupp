import 'dart:convert';

class RecipeFields{
  static final String id = 'id';
  static final String title = 'title';
  static final String description = 'description';
  static final String tutorial = 'tutorial';
  static final String proteins = 'proteins';
  static final String fats = 'fats';
  static final String carbs = 'carbs';
  static final String calories = 'calories';
  static final String minutes = 'minutes';
  static final String dietWeek = 'dietWeek';
  static final String breakfast = 'breakfast';
  static final String dinner = 'dinner';
  static final String supper = 'supper';
  static final String vegeterian = 'vegeterian';
  static final String magnesium = 'magnesium';
  static final String sulfur = 'sulfur';
  static final String protein = 'protein';
  static final String silicon = 'silicon';
  static final String netrogen = 'netrogen';
  static final String chlorine = 'chlorine';
  static final String calcium = 'calcium';
  static final String manganese = 'manganese';
  static final String water = 'water';
  static final String iron = 'iron';
  static final String carbon = 'carbon';
  static final String picture = 'picture';

  static List<String> getFields() => [id, title, description, tutorial, proteins, fats, carbs, calories, minutes, dietWeek, breakfast, dinner, supper, vegeterian, magnesium, sulfur, protein, silicon, netrogen, chlorine, calcium, manganese, water, iron, carbon, picture];
}

class Recipe{
  final String id;
  final String title;
  final String description;
  final String tutorial;
  final double proteins;
  final double fats;
  final double carbs;
  final int calories;
  final int minutes;
  final int dietWeek;
  final bool breakfast;
  final bool dinner;
  final bool supper;
  final bool vegeterian;
  final bool magnesium;
  final bool sulfur;
  final bool protein;
  final bool silicon;
  final bool netrogen;
  final bool chlorine;
  final bool calcium;
  final bool manganese;
  final bool water;
  final bool iron;
  final bool carbon;
  final String picture;

  const Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.tutorial,
    required this.proteins,
    required this.fats,
    required this.carbs,
    required this.calories,
    required this.minutes,
    required this.dietWeek,
    required this.breakfast,
    required this.dinner,
    required this.supper,
    required this.vegeterian,
    required this.magnesium,
    required this.sulfur,
    required this.protein,
    required this.silicon,
    required this.netrogen,
    required this.chlorine,
    required this.calcium,
    required this.manganese,
    required this.water,
    required this.iron,
    required this.carbon,
    required this.picture,
  });

  static Recipe fromJson(Map<String, dynamic> json) => Recipe(
    id: json[RecipeFields.id],
    title: json[RecipeFields.title],
    description: json[RecipeFields.description],
    tutorial: json[RecipeFields.tutorial],
    proteins: jsonDecode(json[RecipeFields.proteins]),
    fats: jsonDecode(json[RecipeFields.fats]),
    carbs: jsonDecode(json[RecipeFields.carbs]),
    calories: jsonDecode(json[RecipeFields.calories]),
    minutes: jsonDecode(json[RecipeFields.minutes]),
    dietWeek: jsonDecode(json[RecipeFields.dietWeek]),
    breakfast: jsonDecode(json[RecipeFields.breakfast]),
    dinner: jsonDecode(json[RecipeFields.dinner]),
    supper: jsonDecode(json[RecipeFields.supper]),
    vegeterian: jsonDecode(json[RecipeFields.vegeterian]),
    magnesium: jsonDecode(json[RecipeFields.magnesium]),
    sulfur: jsonDecode(json[RecipeFields.sulfur]),
    protein: jsonDecode(json[RecipeFields.protein]),
    silicon: jsonDecode(json[RecipeFields.silicon]),
    netrogen: jsonDecode(json[RecipeFields.netrogen]),
    chlorine: jsonDecode(json[RecipeFields.chlorine]),
    calcium: jsonDecode(json[RecipeFields.calcium]),
    manganese: jsonDecode(json[RecipeFields.manganese]),
    water: jsonDecode(json[RecipeFields.water]),
    iron: jsonDecode(json[RecipeFields.iron]),
    carbon: jsonDecode(json[RecipeFields.carbon]),
    picture: json[RecipeFields.picture],
  );

  Map<String, dynamic> toJson() => {
    RecipeFields.id : id,
    RecipeFields.title: title,
    RecipeFields.description: description,
    RecipeFields.tutorial: tutorial,
    RecipeFields.proteins: proteins.toString(),
    RecipeFields.fats: fats.toString(),
    RecipeFields.carbs: carbs.toString(),
    RecipeFields.calories: calories.toString(),
    RecipeFields.minutes: minutes.toString(),
    RecipeFields.dietWeek: dietWeek.toString(),
    RecipeFields.breakfast: breakfast.toString(),
    RecipeFields.dinner: dinner.toString(),
    RecipeFields.supper: supper.toString(),
    RecipeFields.vegeterian: vegeterian.toString(),
    RecipeFields.magnesium: magnesium.toString(),
    RecipeFields.sulfur: sulfur.toString(),
    RecipeFields.protein: protein.toString(),
    RecipeFields.silicon: silicon.toString(),
    RecipeFields.netrogen: netrogen.toString(),
    RecipeFields.chlorine: chlorine.toString(),
    RecipeFields.calcium: calcium.toString(),
    RecipeFields.manganese: manganese.toString(),
    RecipeFields.water: water.toString(),
    RecipeFields.iron: iron.toString(),
    RecipeFields.carbon: carbon.toString(),
    RecipeFields.picture: picture,
  };
}