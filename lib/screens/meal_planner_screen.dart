import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../data/sample_recipes.dart';
import '../services/grocery_list_service.dart';

class MealPlannerScreen extends StatefulWidget {
  const MealPlannerScreen({super.key});

  @override
  State<MealPlannerScreen> createState() => _MealPlannerScreenState();
}

class _MealPlannerScreenState extends State<MealPlannerScreen> {
  final Map<String, Recipe?> weekPlan = {
    'Mon': null,
    'Tue': null,
    'Wed': null,
    'Thu': null,
    'Fri': null,
    'Sat': null,
    'Sun': null,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: weekPlan.keys.map((day) {
              final Recipe? selectedRecipe = weekPlan[day];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                child: ListTile(
                  title: Text(day),
                  subtitle: Text(selectedRecipe?.title ?? 'Select Recipe'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      final Recipe? recipe = await showDialog<Recipe>(
                        context: context,
                        builder: (_) => SimpleDialog(
                          title: const Text('Select Recipe'),
                          children: sampleRecipes.map((r) =>
                            SimpleDialogOption(
                              onPressed: () => Navigator.pop(context, r),
                              child: Text(r.title),
                            ),
                          ).toList(),
                        ),
                      );
                      if (recipe != null) {
                        setState(() => weekPlan[day] = recipe);
                      }
                    },
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: ElevatedButton.icon(
            icon: const Icon(Icons.shopping_cart),
            label: const Text('Generate Grocery List'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
            ),
            onPressed: () {
              final List<String> groceryList =
                  GroceryListService.generateGroceryList(weekPlan);
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Grocery List'),
                  content: SingleChildScrollView(
                    child: Text(groceryList.join('\n')),
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
          ),
        ),
      ],
    );
  }
}
