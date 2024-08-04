import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final bool isSaved;
  final void Function(Recipe) onToggleSaved;

  const RecipeCard({
    Key? key,
    required this.recipe,
    required this.isSaved,
    required this.onToggleSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.all(8.0),
        leading: Image.network(recipe.image, width: 100, height: 100, fit: BoxFit.cover),
        title: Text(recipe.title,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),),
        subtitle:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(recipe.servings),
            Text(
              'Instructions:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            ExpansionTile(
              title: Text(
                'View Instructions',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[600],
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    recipe.instructions,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.indigo,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Like this recipe?'),
            IconButton(
              icon: Icon(isSaved ? Icons.favorite : Icons.favorite_border),
              color: isSaved ? Colors.red : null,
              onPressed: () => onToggleSaved(recipe),
            ),
          ],
        ),
        tileColor: Colors.orangeAccent,
      )
    );
  }
}
