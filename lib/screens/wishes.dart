import 'package:flutter/material.dart';
import 'package:yourdiet/elements/app_topbar.dart';
import 'dart:developer';
import '../elements/big_text.dart';
import '../elements/want_card.dart';
import '../elements/list_gap.dart';
import '../elements/toast.dart';

class WishesScreen extends StatefulWidget {
  const WishesScreen({Key? key}) : super(key: key);

  @override
  _WishesScreen createState() => _WishesScreen();
}

class _WishesScreen extends State<WishesScreen> {

  List<String> _chosen = [];
  List<String> chosen = [];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    bool _active = false;

    void _handleTapboxChanged(Map newValue) {
      setState(() {
        _active = newValue['active'];
        if(_active){
          _chosen.add(newValue['type']);
        }else{
          _chosen.remove(newValue['type']);
        }
      });

      chosen = _chosen.toSet().toList(); //removing duplicated elements

      log(_active.toString() + ' ' + chosen.toString() + ' ' + chosen.length.toString());
    }

    void nextPressed(){
      if(chosen.length > 0) {
        Navigator.pushNamed(context, '/user_parameters',
            arguments: {'lifestyle': args['lifestyle'], 'wishes': chosen});
      }else{
        showToast('Выберите хотя бы 1 пункт', context);
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
          alignment: Alignment.bottomCenter,
          child: ListView(
              children: <Widget> [
                listGap(),
                bigText('Чего вам часто хочется?'),
                listGap(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    wantCard(
                        writing: 'Шоколад',
                        imagePath: 'assets/graphics/chocolate.png',
                        type: 'magnesium',
                        active: _active,
                        onChanged: _handleTapboxChanged
                    ),
                    wantCard(
                        writing: 'Кислое',
                        imagePath: 'assets/graphics/lemon.png',
                        type: 'magnesium',
                        active: _active,
                        onChanged: _handleTapboxChanged
                    ),
                    wantCard(
                        writing: 'Кофе / чай',
                        imagePath: 'assets/graphics/coffee.png',
                        type: 'sulfur',
                        active: _active,
                        onChanged: _handleTapboxChanged
                    ),
                  ]
                ),
                listGap(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      wantCard(
                          writing: 'Фастфуд',
                          imagePath: 'assets/graphics/fast_food.png',
                          type: 'calcium',
                          active: _active,
                          onChanged: _handleTapboxChanged
                      ),
                      wantCard(
                          writing: 'Алкоголь',
                          imagePath: 'assets/graphics/liquor.png',
                          type: 'protein',
                          active: _active,
                          onChanged: _handleTapboxChanged
                      ),
                      wantCard(
                          writing: 'Курение',
                          imagePath: 'assets/graphics/cigarrete.png',
                          type: 'silicon',
                          active: _active,
                          onChanged: _handleTapboxChanged
                      ),
                    ]
                ),
                listGap(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      wantCard(
                          writing: 'Хлеб',
                          imagePath: 'assets/graphics/bread.png',
                          type: 'nitrogen',
                          active: _active,
                          onChanged: _handleTapboxChanged
                      ),
                      wantCard(
                          writing: 'Жареное',
                          imagePath: 'assets/graphics/roast_chicken.png',
                          type: 'carbon',
                          active: _active,
                          onChanged: _handleTapboxChanged
                      ),
                      wantCard(
                          writing: 'Газировка',
                          imagePath: 'assets/graphics/soda_drink.png',
                          type: 'calcium',
                          active: _active,
                          onChanged: _handleTapboxChanged
                      ),
                    ]
                ),
                listGap(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      wantCard(
                          writing: 'Солёное',
                          imagePath: 'assets/graphics/nachos.png',
                          type: 'chlorine',
                          active: _active,
                          onChanged: _handleTapboxChanged
                      ),
                      wantCard(
                          writing: 'Сладкое',
                          imagePath: 'assets/graphics/cupcake.png',
                          type: 'carbon',
                          active: _active,
                          onChanged: _handleTapboxChanged
                      ),
                      wantCard(
                          writing: 'Грызть лёд',
                          imagePath: 'assets/graphics/ice.png',
                          type: 'iron',
                          active: _active,
                          onChanged: _handleTapboxChanged
                      ),
                    ]
                ),
                listGap(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      wantCard(
                          writing: 'Жидкая\nпища',
                          imagePath: 'assets/graphics/soup.png',
                          type: 'water',
                          active: _active,
                          onChanged: _handleTapboxChanged
                      ),
                      wantCard(
                          writing: 'Холодные\nнапитки',
                          imagePath: 'assets/graphics/cold_drink.png',
                          type: 'manganese',
                          active: _active,
                          onChanged: _handleTapboxChanged
                      ),
                    ]
                ),

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
                listGap(),
                listGap()
              ]
          )
      ),
    );
    /*return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Hello World',
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontSize: 32,
              color: Colors.black87,
            ),
          ),
          ElevatedButton(
            // Within the SecondScreen widget
              child: Text('Go back!'),
              onPressed: () {
                Navigator.pop(context);
              }
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
                primary: Colors.greenAccent,
                onPrimary: Colors.grey.shade800,
                elevation: 5,
                textStyle: const TextStyle(
                    fontSize: 25
                )
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/food_wishes');
            },
            child: const Text('Далее'),
          ),
        ],

      ),
    );*/

  }
}