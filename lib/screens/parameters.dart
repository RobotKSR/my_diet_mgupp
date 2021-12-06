import 'package:flutter/material.dart';
import 'package:yourdiet/elements/app_topbar.dart';
import 'dart:developer';
import '../elements/big_text.dart';
import '../elements/list_gap.dart';
import '../elements/gender_field.dart';
import '../elements/age_field.dart';
import '../elements/height_field.dart';
import '../elements/weight_field.dart';
import '../elements/toast.dart';

class ParametersScreen extends StatefulWidget {
  const ParametersScreen({Key? key}) : super(key: key);

  @override
  _ParametersScreen createState() => _ParametersScreen();
}

class _ParametersScreen extends State<ParametersScreen> {

  String gender = 'female';
  String ageGroup = '18-25';
  int height = 170;
  double weight = 0;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    void onGenderChanged(String newValue) {
      setState(() {
        gender = newValue;
      });

      log(gender.toString());
    }

    void onAgeChanged(String newValue) {
      setState(() {
        ageGroup = newValue;
      });

      log(ageGroup.toString());
    }

    void onHeightChanged(int newValue) {
      setState(() {
        height = newValue;
      });

      log(height.toString());
    }

    void onWeightChanged(double newValue) {
      setState(() {
        weight = newValue;
      });

      log(weight.toString());
    }

    void nextPressed(){
      if(weight > 0.9) {
        Navigator.pushNamed(context, '/user_goals', arguments: {'lifestyle': args['lifestyle'], 'wishes': args['wishes'], 'gender': gender, 'ageGroup': ageGroup, 'height': height, 'weight': weight});
      }else{
        showToast('Введите ваш вес', context);
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
              children: <Widget> [
                listGap(),
                bigText('Введите свои параметры'),
                listGap(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      genderField(onChanged: onGenderChanged),
                      ageField(onChanged: onAgeChanged),
                    ]
                ),
                listGap(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      heightField(onChanged: onHeightChanged)
                    ]
                ),
                listGap(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      weightField(title: 'Вес, кг', writing: 'сейчас', onChanged: onWeightChanged)
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
      ),
    );

  }
}