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

  Future<void> _removeFromFavourites(Recipe recipe) async {
    await DBService.removeFavourite(recipe.id); 
    await _loadFavourites(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Favourites'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: favourites.isEmpty
          ? const Center(child: Text('No favourites yet.'))
          : ListView.builder(
              itemCount: favourites.length,
              itemBuilder: (context, index) {
                final recipe = favourites[index];
                return Dismissible(
                  key: Key(recipe.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 24),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) => _removeFromFavourites(recipe),
                  child: RecipeCard(
                    recipe: recipe,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RecipeDetailScreen(recipe: recipe),
                      ),
                    ).then((_) => _loadFavourites()),
                  ),
                );
              },
            ),
    );
  }
}
