// pages/saved_recipes_page.dart
import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../widget/recipecard.dart';

class SavedRecipesPage extends StatelessWidget {
  final List<Recipe> savedRecipes;

  const SavedRecipesPage({Key? key, required this.savedRecipes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Recipes'),
      ),
      body: ListView.builder(
        itemCount: savedRecipes.length,
        itemBuilder: (context, index) {
          return RecipeCard(
            recipe: savedRecipes[index],
            isSaved: true,
            onToggleSaved: (recipe) {},
          );
        },
      ),
    );
  }
}
