import 'dart:convert';

class UserFields{
  static final String id = 'id';
  static final String lifestyle = 'lifestyle';
  static final String wishes = 'wishes';
  static final String gender = 'gender';
  static final String ageGroup = 'ageGroup';
  static final String height = 'height';
  static final String weight = 'weight';
  static final String targetWeight = 'targetWeight';
  static final String foodType = 'foodType';
  static final String calories = 'calories';
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
  static final String date = 'date';

  static List<String> getFields() => [id, lifestyle, wishes, gender, ageGroup, height, weight, targetWeight, foodType, calories, magnesium, sulfur, protein, silicon, netrogen, chlorine, calcium, manganese, water, iron, carbon, date];
}

class User{
  final String id;
  final String lifestyle;
  final String wishes;
  final String gender;
  final String ageGroup;
  final int height;
  final double weight;
  final double targetWeight;
  final String foodType;
  final int calories;
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
  final String date;

  const User({
    required this.id,
    required this.lifestyle,
    required this.wishes,
    required this.gender,
    required this.ageGroup,
    required this.height,
    required this.weight,
    required this.targetWeight,
    required this.foodType,
    required this.calories,
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
    required this.date,
  });

  User copy ({
    String? id,
    String? lifestyle,
    String? wishes,
    String? gender,
    String? ageGroup,
    int? height,
    double? weight,
    double? targetWeight,
    String? foodType,
    int? calories,
    bool? magnesium,
    bool? sulfur,
    bool? protein,
    bool? silicon,
    bool? netrogen,
    bool? chlorine,
    bool? calcium,
    bool? manganese,
    bool? water,
    bool? iron,
    bool? carbon,
    String? date,
  }) =>
      User(
        id: id ?? this.id,
        lifestyle: lifestyle ?? this.lifestyle,
        wishes: wishes ?? this.wishes,
        gender: gender ?? this.gender,
        ageGroup: ageGroup ?? this.ageGroup,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        targetWeight: targetWeight ?? this.targetWeight,
        foodType: foodType ?? this.foodType,
        calories: calories ?? this.calories,
        magnesium: magnesium ?? this.magnesium,
        sulfur: sulfur ?? this.sulfur,
        protein: protein ?? this.protein,
        silicon: silicon ?? this.silicon,
        netrogen: netrogen ?? this.netrogen,
        chlorine: chlorine ?? this.chlorine,
        calcium: calcium ?? this.calcium,
        manganese: manganese ?? this.manganese,
        water: water ?? this.water,
        iron: iron ?? this.iron,
        carbon: carbon ?? this.carbon,
        date: date ?? this.date,
      );

  static User fromJson(Map<String, dynamic> json) => User(
    id: json[UserFields.id],
    lifestyle: json[UserFields.lifestyle],
    wishes: json[UserFields.wishes],
    gender: json[UserFields.gender],
    ageGroup: json[UserFields.ageGroup],
    height: jsonDecode(json[UserFields.height]),
    weight: jsonDecode(json[UserFields.weight]),
    targetWeight: jsonDecode(json[UserFields.targetWeight]),
    foodType: json[UserFields.foodType],
    calories: jsonDecode(json[UserFields.calories]),
    magnesium: jsonDecode(json[UserFields.magnesium]),
    sulfur: jsonDecode(json[UserFields.sulfur]),
    protein: jsonDecode(json[UserFields.protein]),
    silicon: jsonDecode(json[UserFields.silicon]),
    netrogen: jsonDecode(json[UserFields.netrogen]),
    chlorine: jsonDecode(json[UserFields.chlorine]),
    calcium: jsonDecode(json[UserFields.calcium]),
    manganese: jsonDecode(json[UserFields.manganese]),
    water: jsonDecode(json[UserFields.water]),
    iron: jsonDecode(json[UserFields.iron]),
    carbon: jsonDecode(json[UserFields.carbon]),
    date: json[UserFields.date],
  );

  Map<String, dynamic> toJson() => {
    UserFields.id : id,
    UserFields.lifestyle: lifestyle,
    UserFields.wishes: wishes,
    UserFields.gender: gender,
    UserFields.ageGroup: ageGroup,
    UserFields.height: height,
    UserFields.weight: weight.toString(),
    UserFields.targetWeight: targetWeight.toString(),
    UserFields.foodType: foodType,
    UserFields.calories: calories,
    UserFields.magnesium: magnesium.toString(),
    UserFields.sulfur: sulfur.toString(),
    UserFields.protein: protein.toString(),
    UserFields.silicon: silicon.toString(),
    UserFields.netrogen: netrogen.toString(),
    UserFields.chlorine: chlorine.toString(),
    UserFields.calcium: calcium.toString(),
    UserFields.manganese: manganese.toString(),
    UserFields.water: water.toString(),
    UserFields.iron: iron.toString(),
    UserFields.carbon: carbon.toString(),
    UserFields.date: date,
  };
}