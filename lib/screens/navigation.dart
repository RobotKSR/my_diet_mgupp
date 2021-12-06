import 'package:flutter/material.dart';
import 'package:yourdiet/elements/app_topbar.dart';
import 'package:yourdiet/screens/menu.dart';
import 'package:yourdiet/screens/profile.dart';
import 'package:yourdiet/screens/recipe_book.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreen();
}

class _NavigationScreen extends State<NavigationScreen> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget ScreenSwitcher(){
    if(_selectedIndex == 0){
      return RecipeBookScreen();
    }
    if(_selectedIndex == 1){
      return MenuScreen();
    }
    if(_selectedIndex == 2){
      return ProfileScreen();
    }
    return MenuScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          title: topBar(),
      ),
      body:  ScreenSwitcher(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book_rounded),
            label: 'Книга Рецептов',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Мое Меню',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Профиль',
          ),
        ],
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}