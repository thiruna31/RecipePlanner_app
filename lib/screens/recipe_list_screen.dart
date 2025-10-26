import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../data/sample_recipes.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: const Color.fromARGB(255, 0, 201, 168),
  scaffoldBackgroundColor: Colors.grey[100],
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 1, 79, 80),
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20,
    ),
  ),
  useMaterial3: true,
);

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({Key? key}) : super(key: key);

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  String dietFilter = 'all';

  static const List<String> nonVegTitles = [
    "Burger", "Burrito", "Chicken Curry", "Grilled Fish", "Fried Rice", "Omelette"
  ];

  final Set<Recipe> favoriteRecipes = {};

  List<Recipe> get filteredRecipes {
    if (dietFilter == 'all') return sampleRecipes;
    if (dietFilter == 'vegetarian') {
      return sampleRecipes.where((r) => !nonVegTitles.contains(r.title)).toList();
    } else if (dietFilter == 'non-vegetarian') {
      return sampleRecipes.where((r) => nonVegTitles.contains(r.title)).toList();
    }
    return sampleRecipes;
  }

  Widget dietTag(Recipe recipe) {
    if (nonVegTitles.contains(recipe.title)) {
      return Container(
        width: 20,
        height: 20,
        margin: const EdgeInsets.only(left: 6),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Icon(Icons.no_food, color: Colors.white, size: 14),
      );
    } else {
      return const Icon(Icons.eco, color: Colors.green, size: 22);
    }
  }

  Widget favoriteButton(Recipe recipe) {
    final isFav = favoriteRecipes.contains(recipe);
    return IconButton(
      icon: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () {
        setState(() {
          if (isFav) {
            favoriteRecipes.remove(recipe);
          } else {
            favoriteRecipes.add(recipe);
          }
        });
      },
      tooltip: isFav ? 'Remove from Favorites' : 'Add to Favorites',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PLAN LESS EAT BETTER'),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
                // Show favorites in AlertDialog (replace with navigation for full favorites screen)
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Favorite Recipes'),
                    content: SizedBox(
                      width: double.maxFinite,
                      child: ListView(
                        shrinkWrap: true,
                        children: favoriteRecipes.map((r) => ListTile(
                          title: Text(r.title),
                        )).toList(),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              child: Row(
                children: [
                  ChoiceChip(
                    label: const Text('All'),
                    selected: dietFilter == 'all',
                    onSelected: (_) => setState(() => dietFilter = 'all'),
                    selectedColor: Colors.teal,
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('Veg'),
                    selected: dietFilter == 'vegetarian',
                    onSelected: (_) => setState(() => dietFilter = 'vegetarian'),
                    selectedColor: Colors.teal,
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('Non-Veg'),
                    selected: dietFilter == 'non-vegetarian',
                    onSelected: (_) => setState(() => dietFilter = 'non-vegetarian'),
                    selectedColor: Colors.teal,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: GridView.builder(
                  itemCount: filteredRecipes.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 per row
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1, // square
                  ),
                  itemBuilder: (context, idx) {
                    final recipe = filteredRecipes[idx];
                    return GestureDetector(
                      onTap: () {}, // Add detail navigation here
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: recipe.imageUrl.startsWith('http')
                                  ? Image.network(recipe.imageUrl, fit: BoxFit.cover)
                                  : Image.asset(recipe.imageUrl, fit: BoxFit.cover),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Text(
                                    recipe.title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      dietTag(recipe),
                                      favoriteButton(recipe),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
