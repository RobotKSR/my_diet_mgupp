import 'package:flutter/material.dart';
import 'package:yourdiet/api_sheets/recipes_sheets_api.dart';
import 'package:yourdiet/api_sheets/user_sheets_api.dart';
import 'package:yourdiet/model/user.dart';
import 'dart:developer';
import '../elements/list_gap.dart';
import '../elements/calculation_card.dart';
import '../elements/weight_status.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {

  var user;
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

  bool loaded = false;

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
    getUserInfo();
  }

  void getUserInfo() async{
    user = await UserSheetsAPI.getById(uid);
    //if(user != null) log(user.toJson().toString());

    calculate();
  }

  void calculate() {
    double height = user.height / 100;
    double weight = user.weight;
    double result = weight / (height*height);
    bodyMassIndex = double.parse(result.toStringAsFixed(2));

    double age = 22;
    if(user.ageGroup == '18-25'){
      age = 22;
    }else if(user.ageGroup == '26-35'){
      age = 31;
    }else if(user.ageGroup == '36-55'){
      age = 46;
    }else if(user.ageGroup == '56-65'){
      age = 61;
    }else if(user.ageGroup == '65+'){
      age = 75;
    }

    if(user.gender == 'male') {
      bmr = 88.362 + (13.397 * weight) + (4.799 * height * 100) - (5.677 * age);
    }else{
      bmr = 447.593 + (9.247 * weight) + (3.098 * height * 100) - (4.330 * age);
    }

    if(user.lifestyle == 'minimum'){
      amr = 1.2;
    }else if(user.lifestyle == 'medium'){
      amr = 1.5;
    }else if(user.lifestyle == 'maximum'){
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

    double targetWeight = user.targetWeight;
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

    setState(() {
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {

    void againPressed() async{
      Navigator.pushNamed(context, '/welcome');
    }

    void launchURL() async {
      if (!await launch('https://sites.google.com/view/my-diet-disclamer/home')) throw 'Could not launch url';
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
      return Container(
          color: Colors.grey.shade100,
          alignment: Alignment.bottomCenter,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //bigText(args.toString()),
                listGap(),
                weightStatusCard(
                    context, 'Статус веса:', weightStatus[weightStatusCurrent],
                    weightStatusColor[weightStatusCurrent], Colors.white),
                listGap(),
                calculationCard(context, 'Индекс массы тела (ИМТ):',
                    bodyMassIndex.toString(), Colors.white,
                    Colors.black, FontWeight.normal),
                listGap(),
                calculationCard(context, 'Базальный метаболизм (ккал):',
                    bmr.toStringAsFixed(0), Colors.white, Colors.black,
                    FontWeight.normal),
                listGap(),
                calculationCard(context, 'Активный метаболизм (ккал):',
                    caloriesNormal.toString(), Colors.white, Colors.black,
                    FontWeight.normal),
                listGap(),
                calculationCard(
                    context, recommended, caloriesForTargetWeight.toString(),
                    Colors.white, Colors.black, FontWeight.bold),
                listGap(),
                listGap(),
                      Padding (
                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                        child: ElevatedButton(
                        clipBehavior: Clip.antiAlias,
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(15))),
                            elevation: 5,
                            //fixedSize: Size(150, 250),
                            textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                            ),
                          primary: Colors.white,
                          onPrimary: Colors.blue.shade700,
                        ),
                        onPressed: againPressed,
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                            child:Text('Пройти опрос заново', textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                            child:Image(
                              image: AssetImage('assets/graphics/refresh.png'),
                              width: MediaQuery.of(context).size.width * 0.1,
                            ),
                          ),
                        ]
                        )
                        ),
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
      );
    }
  }
}