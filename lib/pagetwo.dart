import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/rendering.dart'; //adds support for @required

import 'main.dart';

final _recipeIconWidth = 50.0;
final _recipeIconHeight = 50.0;
final _paddingInRecipe = 5.0;

class PageTwo extends StatefulWidget {
  final List<Ingredient> ingredientList;
  final List<Recipe> recipeList;
  PageTwo({
    Key key,
    this.ingredientList,
    this.recipeList,
  }) : super(key: key);

  @override
  PageTwoState createState() => PageTwoState();
}

class PageTwoState extends State<PageTwo> {
  bool cmpIngStr(Ingredient ing, String str) {
    return ing.name == str;
  }

  bool ingredientListContains(List<Ingredient> ingLi, String ing) {
    if (ingLi.length == null) {
      return false;
    }
    for (int i = 0; i < ingLi.length; i++) {
      if (ingLi[i].name == ing) {
        return true;
      }
    }
    return false;
  }

  List<Recipe> getRecipes() {
    List<Recipe> retList = [];
    List<Ingredient> availableIngredients =
        widget.ingredientList.where((ing) => ing.checked == true).toList();
    var avIng = Map.fromIterable(availableIngredients,
        key: (v) => v.name, value: (v) => v.checked);

    // for recipe in recipe database
    for (int i = 0; i < widget.recipeList.length; i++) {
      //for ingredient in recipe
      bool allIngredientsHad = true;
      for (int j = 0;
          j < widget.recipeList[i].requiredIngredients.length;
          j++) {
        //if ingredient is not selected, do not add ingredient to retList
        if (avIng.containsKey(widget.recipeList[i].requiredIngredients[j]) ==
            false) {
          allIngredientsHad = false;
        }
      }
      //if all ingredients were selected, add recipe to retList
      if (allIngredientsHad) {
        retList.add(widget.recipeList[i]);
      }
    }
    return retList;
  }

  @override
  Widget build(BuildContext context) {
    List<Recipe> availableRec = getRecipes();
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
          child: Text("Showing possible combinations of " +
            widget.ingredientList
                .where((ing) => ing.checked == true)
                .length
                .toString() + " ingredients",
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: availableRec.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.green[400],
                  elevation: 3.5,
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: InkWell(
                    onTap: () {
                      // should be used in the future to get more information
                      null;
                    },
                    child: Column(
                      children: <Widget>[
                        Card(
                            margin: EdgeInsets.all(_paddingInRecipe),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child:
                                      Image.asset(availableRec[index].iconLoc),
                                  width: _recipeIconWidth,
                                  height: _recipeIconHeight,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6.0, horizontal: 4.0),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      availableRec[index].name,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      availableRec[index].description,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey[500],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )),
                        Card(
                          margin: EdgeInsets.fromLTRB(_paddingInRecipe, 0.0,
                              _paddingInRecipe, _paddingInRecipe),
                          child: Padding(
                            // Padding around text in ingredient box
                            padding: const EdgeInsets.all(7.0),
                            child: Text(
                              availableRec[index].requiredIngredients.join(", "),
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}