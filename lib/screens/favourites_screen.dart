import 'package:flutter/material.dart';
import '../services/db_service.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';
import 'recipe_detail_screen.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  List<Recipe> favourites = [];

  @override
  void initState() {
    super.initState();
    _loadFavourites();
  }

  Future<void> _loadFavourites() async {
    favourites = await DBService.getFavourites();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return favourites.isEmpty
        ? const Center(child: Text('No favourites yet.'))
        : ListView.builder(
            itemCount: favourites.length,
            itemBuilder: (context, index) {
              final recipe = favourites[index];
              return RecipeCard(
                recipe: recipe,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RecipeDetailScreen(recipe: recipe),
                  ),
                ),
              );
            },
          );
  }
}
