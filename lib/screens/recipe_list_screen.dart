import 'package:flutter/material.dart';
import '../data/sample_recipes.dart';
import '../widgets/recipe_card.dart';
import 'recipe_detail_screen.dart';
import '../models/recipe.dart';
import '../widgets/filter_section.dart';
import '../utils/filters.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  bool _vegan = false;
  bool _vegetarian = false;
  bool _glutenFree = false;

  @override
  Widget build(BuildContext context) {
    List<Recipe> filtered = sampleRecipes.where((r) {
      return Filters.apply(r, _vegan, _vegetarian, _glutenFree);
    }).toList();

    return Column(
      children: [
        FilterSection(
          vegan: _vegan,
          vegetarian: _vegetarian,
          glutenFree: _glutenFree,
          onChanged: (v, vg, gf) {
            setState(() {
              _vegan = vg;
              _vegetarian = v;
              _glutenFree = gf;
            });
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final recipe = filtered[index];
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
          ),
        ),
      ],
    );
  }
}
