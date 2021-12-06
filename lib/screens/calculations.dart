import 'package:flutter/material.dart';
import 'package:yourdiet/api_sheets/recipes_sheets_api.dart';
import 'package:yourdiet/api_sheets/user_sheets_api.dart';
import 'package:yourdiet/elements/app_topbar.dart';
import 'package:yourdiet/model/user.dart';
import 'dart:developer';
import '../elements/list_gap.dart';
import '../elements/calculation_card.dart';
import '../elements/weight_status.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class CalculationsScreen extends StatefulWidget {
  const CalculationsScreen({Key? key}) : super(key: key);

  @override
  _CalculationsScreen createState() => _CalculationsScreen();
}

class _CalculationsScreen extends State<CalculationsScreen> {

  String uid = '';
  double bodyMassIndex = 0;
  int caloriesNormal = 0;
  double bmr = 0;
  double amr = 1.2;
  int caloriesForTargetWeight = 0;
  List<String> weightStatus = ['выраженный дефицит', 'недостаток веса', 'нормальный', 'излишний вес', 'ожирение I степени', 'ожирение II степени', 'ожирение III степени'];
  List<Color> weightStatusColor = [Colors.red, Colors.orange.shade800, Colors.green, Colors.orange.shade800, Colors.orange.shade900, Colors.red, Colors.red];
  int weightStatusCurrent = 0;

  String recommended = '';

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
    log('uid loaded: $uid');
    if(uid == 'none') saveNewId();
  }

  void saveNewId() async{
    setState(() {
      uid = Uuid().v4();
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', uid);
    log('uid saved: $uid');
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    double height = args['height'] / 100;
    double weight = args['weight'];
    double result = weight / (height*height);
    bodyMassIndex = double.parse(result.toStringAsFixed(2));

    double age = 22;
    if(args['ageGroup'] == '18-25'){
      age = 22;
    }else if(args['ageGroup'] == '26-35'){
      age = 31;
    }else if(args['ageGroup'] == '36-55'){
      age = 46;
    }else if(args['ageGroup'] == '56-65'){
      age = 61;
    }else if(args['ageGroup'] == '65+'){
      age = 75;
    }

    if(args['gender'] == 'male') {
      bmr = 88.362 + (13.397 * weight) + (4.799 * height * 100) - (5.677 * age);
    }else{
      bmr = 447.593 + (9.247 * weight) + (3.098 * height * 100) - (4.330 * age);
    }

    if(args['lifestyle'] == 'minimum'){
      amr = 1.2;
    }else if(args['lifestyle'] == 'medium'){
      amr = 1.5;
    }else if(args['lifestyle'] == 'maximum'){
      amr = 1.8;
    }

    if(bodyMassIndex < 16){
      weightStatusCurrent = 0;
    }else if(bodyMassIndex >= 16 && bodyMassIndex < 18.5){
      weightStatusCurrent = 1;
    }else if(bodyMassIndex >= 18.5 && bodyMassIndex < 25){
      weightStatusCurrent = 2;
    }else if(bodyMassIndex >= 25 && bodyMassIndex < 30){
      weightStatusCurrent = 3;
    }else if(bodyMassIndex >= 30 && bodyMassIndex < 35){
      weightStatusCurrent = 4;
    }else if(bodyMassIndex >= 35 && bodyMassIndex < 40){
      weightStatusCurrent = 5;
    }else if(bodyMassIndex >= 40){
      weightStatusCurrent = 6;
    }

    caloriesNormal = (bmr * amr).round(); //-20% for slow weight losing, -35% for fast weight losing / or -200-400 calories to lose weight

    double targetWeight = args['targetWeight'];
    if(weight > targetWeight){
      recommended = 'Для похудения в день (ккал):';
      caloriesForTargetWeight = ((bmr + caloriesNormal)/2).round();
    }else if(weight < targetWeight){
      recommended = 'Для набора массы \nв день (ккал):';
      caloriesForTargetWeight = (caloriesNormal*2 - (bmr + caloriesNormal)/2).round();
    }else if(weight == targetWeight){
      recommended = 'Для поддержания веса \nв день (ккал):';
      caloriesForTargetWeight = caloriesNormal.round();
    }

    void nextPressed() async{

      DateTime now = DateTime.now();
      String formattedDate = DateFormat('dd.MM.yyyy').format(now);

      List<String> wishes = args['wishes'];
      final user = User(
        id: uid,
        lifestyle: args['lifestyle'],
        wishes: args['wishes'].toString(),
        gender: args['gender'],
        ageGroup: args['ageGroup'],
        height: args['height'],
        weight: args['weight'],
        targetWeight: args['targetWeight'],
        foodType: args['foodType'],
        calories: caloriesForTargetWeight,
        magnesium: wishes.contains('magnesium'),
        sulfur: wishes.contains('sulfur'),
        protein: wishes.contains('protein'),
        silicon: wishes.contains('silicon'),
        netrogen: wishes.contains('netrogen'),
        chlorine: wishes.contains('chlorine'),
        calcium: wishes.contains('calcium'),
        manganese: wishes.contains('manganese'),
        water: wishes.contains('water'),
        iron: wishes.contains('iron'),
        carbon: wishes.contains('carbon'),
        date: formattedDate,
      );

      Navigator.pushNamed(context, '/loading', arguments: {'user': user});
    }

    void launchURL() async {
      if (!await launch('https://sites.google.com/view/my-diet-disclamer/home')) throw 'Could not launch url';
    }

    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          title: topBar(),
      ),
      body: Container(
          color: Colors.grey.shade100,
          alignment: Alignment.bottomCenter,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                listGap(),
          Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                child: const Text('Ваши результаты',
                textAlign: TextAlign.start,
                  style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                    fontFamily: 'Inter'
                  ),
                ),
          ),
                //bigText(args.toString()),
                listGap(),
                weightStatusCard(context, 'Статус веса:', weightStatus[weightStatusCurrent], weightStatusColor[weightStatusCurrent], Colors.white),
                listGap(),
                calculationCard(context, 'Индекс массы тела (ИМТ):', bodyMassIndex.toString(), Colors.white, Colors.black, FontWeight.normal),
                listGap(),
                calculationCard(context, 'Базальный метаболизм (ккал):', bmr.toStringAsFixed(0), Colors.white, Colors.black, FontWeight.normal),
                listGap(),
                calculationCard(context, 'Активный метаболизм (ккал):', caloriesNormal.toString(), Colors.white, Colors.black, FontWeight.normal),
                listGap(),
                calculationCard(context, recommended, caloriesForTargetWeight.toString(), Colors.white, Colors.black, FontWeight.bold),
                listGap(),
                listGap(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
                            primary: Colors.greenAccent.shade700,
                            onPrimary: Colors.white,
                            elevation: 5,
                            textStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Inter'
                            )
                        ),
                        onPressed: nextPressed,
                        child: const Text('Получить персональный план'),
                      ),
                    ]
                ),
                listGap(),
                listGap(),
                GestureDetector(
                    child: Text('Источники рекомендаций',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey.shade800,
                        fontFamily: 'Inter',
                      ),
                    ),
                    onTap: launchURL
                ),
                listGap()
              ]
          )
      ),
    );

  }
}