import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'pageone.dart';
import 'pagetwo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Placeholder",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Key keyOne = PageStorageKey('pageOne');
  final Key keyTwo = PageStorageKey('pageTwo');

  int currentTab = 0;

  PageOne one;
  PageTwo two;
  List<Widget> pages;
  Widget currentPage;

  List<Ingredient> ingredientList;
  final PageStorageBucket bucket = PageStorageBucket();
  List<Recipe> recipeList;

  @override
  void initState() {
    ingredientList = [
      Ingredient(1, "Meatballs", "assets/placeholder.png", false),
      Ingredient(2, "Bacon", "assets/placeholder.png", false),
      Ingredient(3, "Pasta", "assets/placeholder.png", false),
      Ingredient(4, "Egg", "assets/placeholder.png", false),
      Ingredient(5, "Milk", "assets/placeholder.png", false),
      Ingredient(5, "Butter", "assets/placeholder.png", false),
    ];
    recipeList = [
      Recipe(1, "Pasta carbonara", "assets/placeholder.png",
          ["Pasta", "Bacon", "Egg"], "Italian, simple", false),
      Recipe(2, "Omelette", "assets/placeholder.png", ["Egg", "Milk", "Butter"], "Simple, quick", false),
    ];
    one = PageOne(key: keyOne, ingredientList: ingredientList);
    two = PageTwo(
        key: keyTwo, ingredientList: ingredientList, recipeList: recipeList);

    pages = [one, two];
    currentPage = one;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe Finder"),
      ),
      body: PageStorage(
        child: currentPage,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        onTap: (int index) {
          setState(() {
            currentTab = index;
            currentPage = pages[index];
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text(
              "Pick ingredients",
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in),
            title: Text("See recipes"),
          ),
        ],
      ),
    );
  }
}

class Ingredient {
  final int id;
  final String name;
  final String iconLoc;
  bool checked;
  Ingredient(this.id, this.name, this.iconLoc, this.checked);
}

class Recipe {
  final int id;
  final String name;
  final String iconLoc;
  final List<String> requiredIngredients;
  final String description;
  bool checked;
  Recipe(
      this.id, this.name, this.iconLoc, this.requiredIngredients, this.description, this.checked);
}
