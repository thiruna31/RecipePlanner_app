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
    'Mon': null, 'Tue': null, 'Wed': null, 'Thu': null, 'Fri': null, 'Sat': null, 'Sun': null,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: weekPlan.keys.map((day) {
              return ListTile(
                title: Text(day),
                subtitle: Text(weekPlan[day]?.title ?? 'Select Recipe'),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    final recipe = await showDialog<Recipe>(
                      context: context,
                      builder: (_) => SimpleDialog(
                        title: const Text('Select Recipe'),
                        children: sampleRecipes
                            .map((r) => SimpleDialogOption(
                                  onPressed: () => Navigator.pop(context, r),
                                  child: Text(r.title),
                                ))
                            .toList(),
                      ),
                    );
                    if (recipe != null) {
                      setState(() => weekPlan[day] = recipe);
                    }
                  },
                ),
              );
            }).toList(),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final list = GroceryListService.generateGroceryList(weekPlan);
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Grocery List'),
                content: Text(list.join('\n')),
              ),
            );
          },
          child: const Text('Generate Grocery List'),
        ),
      ],
    );
  }
}
