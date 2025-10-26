import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../models/recipe.dart';
import '../services/db_service.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    _loadFavouriteStatus();
  }

  Future<void> _loadFavouriteStatus() async {
    final favs = await DBService.getFavourites();
    setState(() {
      isFav = favs.any((r) => r.id == widget.recipe.id);
    });
  }

  void shareRecipe() {
    final content = '''
${widget.recipe.title}

Ingredients:
${widget.recipe.ingredients.join(", ")}

Steps:
${widget.recipe.steps.join("\n")}
''';
    Share.share(content);
  }

  Future<void> toggleFavourite() async {
    if (isFav) {
      await DBService.removeFavourite(widget.recipe.id);
    } else {
      await DBService.addFavourite(widget.recipe);
    }
    setState(() => isFav = !isFav);
  }

  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        actions: [
          IconButton(
            icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
            onPressed: toggleFavourite,
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: shareRecipe,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            (recipe.imageUrl.startsWith('http') || recipe.imageUrl.startsWith('https'))
                ? Image.network(recipe.imageUrl, height: 200, fit: BoxFit.cover)
                : Image.asset(recipe.imageUrl, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 16),
            const Text('Ingredients', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...recipe.ingredients.map((e) => Text('• $e')),
            const SizedBox(height: 16),
            const Text('Steps', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...recipe.steps.map((e) => Text('- $e')),
          ],
        ),
      ),
    );
  }
}
