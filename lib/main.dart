import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' ;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourdiet/screens/first.dart';
import 'package:yourdiet/screens/loading.dart';
import 'package:yourdiet/screens/navigation.dart';
import 'package:yourdiet/screens/privacy_policy.dart';
import 'package:yourdiet/screens/terms_of_use.dart';
import 'package:yourdiet/screens/tutorial.dart';
import 'api_sheets/recipes_sheets_api.dart';
import 'screens/activity.dart';
import 'screens/wishes.dart';
import 'screens/parameters.dart';
import 'screens/goals.dart';
import 'screens/calculations.dart';
import 'screens/menu.dart';
import 'api_sheets/user_sheets_api.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await UserSheetsAPI.init();
  await RecipeSheetsAPI.init();

  String uid = '';
  String initial;

  Future<String> loadId() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('uid') ?? 'none';

    return id;
  }

  uid = await loadId();

  if(uid == 'none' || uid == ''){
    initial = '/welcome';
  }else{
    initial = '/navigation';
  }

  log(initial);

  //Set portrait orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) =>
  runApp(
    MaterialApp(
      title: 'Моя Диета',
      theme: ThemeData(fontFamily: 'Manrope'),
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: initial,
      routes: {
        '/welcome': (context) => const FirstScreen(),
        '/privacy_policy': (context) => PrivacyPolicyScreen(),
        '/terms_of_use': (context) => TermsOfUseScreen(),
        '/activity_level': (context) => const ActivityScreen(),
        '/food_wishes': (context) => const WishesScreen(),
        '/user_parameters': (context) => const ParametersScreen(),
        '/user_goals': (context) => const GoalsScreen(),
        '/calculations': (context) => const CalculationsScreen(),
        '/loading': (context) => const LoadingScreen(),
        '/menu': (context) => const MenuScreen(),
        '/navigation': (context) => const NavigationScreen(),
        '/tutorial': (context) => const TutorialScreen(),
      },
    ),
  ));
}


