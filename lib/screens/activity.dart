import 'package:flutter/material.dart';
import 'package:yourdiet/elements/app_topbar.dart';
import 'package:yourdiet/elements/list_gap.dart';
import '../elements/activity_card.dart';
import '../elements/big_text.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              children: [
                bigText('Какой у вас образ жизни?'),
                listGap(),
                activityCard(context, 'Сидячий', 'assets/graphics/minimum_activity.png', Colors.blue.shade200, 'minimum'),
                activityCard(context, 'Умеренный', 'assets/graphics/medium_activity.png', Colors.lightGreen.shade400, 'medium'),
                activityCard(context, 'Активный', 'assets/graphics/maximum_activity.png', Colors.deepOrange.shade300, 'maximum'),
              ]
          )
      ),
    );
  }
}