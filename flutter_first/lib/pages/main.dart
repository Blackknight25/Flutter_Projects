import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';
import '../widget/recipecard.dart';
import 'saved_recipes_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final List<Recipe> _savedRecipes = [];
  late Future<List<Recipe>> _recipesFuture;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _recipesFuture = RecipeService().fetchRecipes('');
  }

  void toggleSavedRecipe(Recipe recipe) {
    setState(() {
      if (_savedRecipes.contains(recipe)) {
        _savedRecipes.remove(recipe);
      } else {
        _savedRecipes.add(recipe);
      }
    });
  }

  void _navigateToSavedRecipes() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SavedRecipesPage(savedRecipes: _savedRecipes)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Awesome Recipe App'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'All Recipes'),
              Tab(text: 'Saved Recipes'),
            ],
          ),
        ),
        body: TabBarView(controller: _tabController, children: [
          FutureBuilder<List<Recipe>>(
            future: _recipesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No recipes found'));
              } else {
                final recipes = snapshot.data!;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // Text widget above the ListView
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Here are some delicious recipes for you to try:',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      // ListView.builder to display recipes
                      ListView.builder(
                        shrinkWrap: true,
                        // Allows ListView to take only as much space as needed
                        physics: const NeverScrollableScrollPhysics(),
                        // Prevent scrolling conflicts with SingleChildScrollView
                        itemCount: recipes.length,
                        itemBuilder: (context, index) {
                          return RecipeCard(
                            recipe: recipes[index],
                            isSaved: _savedRecipes.contains(recipes[index]),
                            onToggleSaved: toggleSavedRecipe,
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
            },
          ), SavedRecipesPage(savedRecipes: _savedRecipes),
        ]));
  }
}
