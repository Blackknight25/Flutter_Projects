class Recipe {
  final String title;
  final String image;
  final String servings;
  final String instructions;

  Recipe({required this.title, required this.image, required this.servings, required this.instructions});

  factory Recipe.fromJson(Map<String, dynamic> json){
    return Recipe(
      title: json['strMeal']?? 'Unknown',
      image: json['strMealThumb']?? 'Unknown',
      servings: json['strArea']?? 'Unknown',
      instructions: json['strInstructions']?? 'Unknown',
    );
  }
}