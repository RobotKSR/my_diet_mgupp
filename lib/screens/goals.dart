import 'package:flutter/material.dart';
import 'package:yourdiet/elements/app_topbar.dart';
import 'dart:developer';
import '../elements/big_text.dart';
import '../elements/list_gap.dart';
import '../elements/weight_field.dart';
import '../elements/foodtype_field.dart';
import '../elements/toast.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({Key? key}) : super(key: key);

  @override
  _GoalsScreen createState() => _GoalsScreen();
}

class _GoalsScreen extends State<GoalsScreen> {

  double targetWeight = 0;
  String foodtype = 'normal';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    void onTargetWeightChanged(double newValue) {
      setState(() {
        targetWeight = newValue;
      });

      log(targetWeight.toString());
    }

    void onFoodtypeChanged(String newValue) {
      setState(() {
        foodtype = newValue;
      });

      log(foodtype.toString());
    }

    void nextPressed(){
      if(targetWeight > 0.9) {
        Navigator.pushNamed(context, '/calculations',
            arguments: {
              'lifestyle': args['lifestyle'],
              'wishes': args['wishes'],
              'gender': args['gender'],
              'ageGroup': args['ageGroup'],
              'height': args['height'],
              'weight': args['weight'],
              'targetWeight': targetWeight,
              'foodType': foodtype
              }
              );
      }else{
        showToast('Введите целевой вес', context);
      }
    }

    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          title: topBar(),
      ),
      body: Container(
          color: Colors.grey.shade100,
          alignment: Alignment.center,
          child: ListView(
              shrinkWrap: true,
          children: [
            Column(
                 mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                listGap(),
                bigText('Укажите целевой вес \nи предпочтения'),
                listGap(),
                listGap(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      weightField(title: 'Вес, кг', writing: 'целевой', onChanged: onTargetWeightChanged)
                    ]
                ),
                listGap(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      foodtypeField(onChanged: onFoodtypeChanged)
                    ]
                ),
                listGap(),
                listGap(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
                            primary: Colors.white,
                            onPrimary: Colors.grey.shade800,
                            elevation: 5,
                            textStyle: const TextStyle(
                                fontSize: 24,
                              fontFamily: 'Inter'
                            )
                        ),
                        onPressed: nextPressed,
                        child: const Text('Далее'),
                      ),
                    ]
                ),
                listGap(),
                listGap()
              ]
          )
          ]
          )
      ),
    );

  }
}