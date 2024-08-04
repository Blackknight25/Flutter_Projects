import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';

class RecipeService {
  final String baseUrl = 'https://www.themealdb.com/api/json/v1/1/search.php?s=';

  Future<List<Recipe>> fetchRecipes(String query) async {
    final response = await http.get(Uri.parse('$baseUrl$query'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> meals = data['meals']??[];
      return meals.map((meal) => Recipe.fromJson(meal)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}