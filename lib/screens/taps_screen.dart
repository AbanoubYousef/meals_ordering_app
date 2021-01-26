import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';
import './categories_screen.dart';
import './favorites_screen.dart';
import '../models/meal.dart';
class TapsScreen extends StatefulWidget {

  final List<Meal> favouriteMeals;
  TapsScreen(this.favouriteMeals);
  @override
  _TapsScreenState createState() => _TapsScreenState();
}

class _TapsScreenState extends State<TapsScreen> {

   List<Map<String, Object>> _pages;
int _pageindex = 0;

@override
  void initState() {
  _pages = [

    {
      'page':CategoriesScreen(),
      'title':'Categories'
    },
    {
      'page':FavoritesScreen(widget.favouriteMeals),
      'title':'Favourite'
    }
  ];
    super.initState();
  }
void _selectedIndex(int index) {
  setState(() {
    _pageindex = index;
  });
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(_pages[_pageindex]['title']),
    ),
    body: _pages[_pageindex]['page'],
    drawer: MainDrawer(),
    bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedIndex,
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme
            .of(context)
            .accentColor,
        currentIndex: _pageindex,
        type: BottomNavigationBarType.shifting,

        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme
                  .of(context)
                  .primaryColor,
              icon: Icon(Icons.category),
              title: Text('Categories')),
          BottomNavigationBarItem(
              backgroundColor: Theme
                  .of(context)
                  .primaryColor,
              icon: Icon(Icons.star),
              title: Text('Favourite'))
        ]
    ),

  );
}}
