import 'package:flutter/material.dart';
import 'package:new_api/models/recipe.api.dart';
import 'package:new_api/models/recipe.dart';
import 'package:new_api/views/widgets/recipe_card.dart';



class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
late List<Recipe> recipes;
bool isloading = true;
 
 @override
  void initState() {
    
    super.initState();
    getRecipes();
  }
  Future<void>getRecipes() async{
    recipes = await RecipeApi.getRecipe();
    setState(() {
      isloading = false;
    });
    
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu),
              SizedBox(width: 10),
              Text('Food Recipes'),
            ],
          ),
      ),
      body: isloading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  return RecipeCard(
                      displayName: recipes[index].displayName,
                     totalTime: recipes[index].totalTime.toString(),
                      rating: recipes[index].rating.toString(),
                      thumbnailUrl: recipes[index].images);
                },
              ));
  }
}