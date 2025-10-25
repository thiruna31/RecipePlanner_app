import 'package:flutter/material.dart';
import '../models/recipe.dart';

class MealPlanItem extends StatelessWidget {
  final String day;
  final Recipe? recipe;
  final VoidCallback onSelect;

  const MealPlanItem({super.key, required this.day, this.recipe, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(day),
      subtitle: Text(recipe?.title ?? 'No recipe selected'),
      trailing: IconButton(icon: const Icon(Icons.add), onPressed: onSelect),
    );
  }
}
