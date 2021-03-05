import 'package:MealsApp/screens/meal_detail_screen.dart';
import 'package:flutter/material.dart';

import '../models/meal.dart';
import './information_item.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  MealItem(
      {@required this.id,
      @required this.title,
      @required this.affordability,
      @required this.complexity,
      @required this.duration,
      @required this.imageUrl});

  String get complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';
      case Complexity.Challenging:
        return 'Challenging';
      case Complexity.Hard:
        return 'Hard';
      default:
        return 'Unknwon';
    }
  }

  String get affordabiltyText {
    switch (affordability) {
      case Affordability.Affordable:
        return 'Low';
      case Affordability.Lux:
        return 'Expensive';
      case Affordability.Pricey:
        return 'Medium';
      default:
        return 'Unknwon';
    }
  }

  void selectMeal(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
      MealDetailScreen.routeName,
      arguments: id,
    )
        .then((result) {
      if (result != null) {
        // removeItem(result);
      } else {
        print(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        selectMeal(context);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    width: 200,
                    color: Colors.black54,
                    padding: EdgeInsets.all(5),
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 26, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InformationItem(icon: Icons.schedule, text: "$duration min"),
                  // SizedBox(
                  //   width: 20,
                  // ),
                  InformationItem(icon: Icons.work, text: complexityText),
                  InformationItem(
                      icon: Icons.attach_money, text: affordabiltyText)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
