import 'package:flutter/material.dart';
import './models/dummy_data.dart';
import './models/meal.dart';
import './screens/taps_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/filters_screen.dart';
import './screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String,bool> _filters={
    'gloten':false,
    'lactose':false,
    'vegetarian':false,
    'vegan':false
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal>_favouriteMeals=[];
   void _setFilters(Map<String,bool> filterData){
     setState(() {
       _filters=filterData;
       _availableMeals=DUMMY_MEALS.where((meal){
         if(_filters['gluten'] && !meal.isGlutenFree)
           return false;
         if(_filters['lactose'] && !meal.isLactoseFree)
           return false;
         if(_filters['vegetarian'] && !meal.isVegetarian)
           return false;
         if(_filters['vegan'] && !meal.isVegan)
           return false;

         return true;

       }).toList();
     });
   }

   void _toggleFavourite(String id){
     final _existingIndex=
         _favouriteMeals.indexWhere((meal)=>meal.id==id);
     if(_existingIndex>=0){
     setState(() {
       _favouriteMeals.removeAt(_existingIndex);
     });
   }else{
       setState(() {
         _favouriteMeals.add(DUMMY_MEALS.firstWhere((meal)=>meal.id==id));
       });
     }
   }

   bool _ismealFavourite(String id){
    return _favouriteMeals.any((meal)=>meal.id==id);
   }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            body2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            title: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/', // default is '/'
      routes: {
        '/': (ctx) => TapsScreen(_favouriteMeals),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavourite,_ismealFavourite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters,_setFilters),
      },

      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);
      },
    );
  }
}
