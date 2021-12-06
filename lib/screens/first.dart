import 'dart:developer';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:yourdiet/elements/app_topbar.dart';
import 'package:yourdiet/elements/list_gap.dart';
import '../elements/activity_card.dart';
import '../elements/big_text.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    void nextPressed() async{
      Navigator.pushNamed(context, '/activity_level');
    }

    void launchURL() async {
      if (!await launch('https://sites.google.com/view/my-diet-disclamer/home')) throw 'Could not launch url';
    }

    return Scaffold(
      /*appBar: AppBar(
        automaticallyImplyLeading: false,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          title: topBar(),
      ),*/
      body: Container(
          color: Colors.white,//Color(0xffF0FFFF),
          alignment: Alignment.bottomCenter,
          /*decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.lightBlueAccent.shade100, Colors.lightBlueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          ),*/
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(
                  image: AssetImage('assets/graphics/app_logo.png'),
                  width: MediaQuery.of(context).size.width * 0.9,
                ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 40),
                  child: const Text('Получите индивидуальный план питания от',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 40),
                  child: const Text('диетологов МГУПП',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                ]
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
                            primary: Colors.green.shade400,
                            onPrimary: Colors.white,
                            elevation: 5,
                            textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Inter'
                            )
                        ),
                        onPressed: nextPressed,
                        child: const Text('ПРОДОЛЖИТЬ'),
                      ),
                    ]
                ),
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Продолжая, вы соглашаетесь с ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade800,
                      fontFamily: 'Inter',
                      ),
                    ),
                    GestureDetector(
                        child: Text('Terms of Service',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade800,
                          fontFamily: 'Inter',
                        ),
                      ),
                        onTap: () {
                          Navigator.pushNamed(context, '/terms_of_use');
                        }
                    )
                  ]
                  ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('и ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade800,
                          fontFamily: 'Inter',
                        ),
                      ),
                      GestureDetector(
                          child: Text('Privacy Policy',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade800,
                              fontFamily: 'Inter',
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/privacy_policy');
                          }
                      )
                    ]
                ),
              ),
               ]
              ),
              ]
          )
      ),
    );
  }
}