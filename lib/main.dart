import 'package:MealsApp/dummy_data.dart';
import 'package:MealsApp/models/meal.dart';
import 'package:flutter/material.dart';

import './screens/meal_detail_screen.dart';
import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/tabs_screen.dart';
import './screens/filters_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'vegan': false,
    'vegeterian': false,
    'lactose': false
  };

  List<Meal> _availabeMeals = DUMMY_MEALS;
  List<Meal> _favoritedMeal = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availabeMeals = _availabeMeals.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        ;
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        ;
        if (_filters['vegeterian'] && !meal.isVegetarian) {
          return false;
        }
        ;
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existedIndex = _favoritedMeal.indexWhere((meal) => meal.id == mealId);
    if (existedIndex >= 0) {
      setState(() {
        _favoritedMeal.removeAt(existedIndex);
      });
    } else {
      setState(() {
        _favoritedMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFav(String mealId) {
    return _favoritedMeal.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              headline6: TextStyle(
                  fontSize: 26,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold),
            ),
      ),
      // home: TabsScreen(), //first screen (Entry Point)
      routes: {
        '/': (ctx) => TabsScreen(_favoritedMeal),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availabeMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isMealFav),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_setFilters, _filters),
      },

      // onGenerateRoute: (settings) {
      //   return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      // },
    );
  }
}
