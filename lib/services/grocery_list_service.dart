import '../models/recipe.dart';

class GroceryListService {
  static List<String> generateGroceryList(Map<String, Recipe?> plan) {
    final ingredients = <String>{};
    for (final recipe in plan.values) {
      if (recipe != null) ingredients.addAll(recipe.ingredients);
    }
    return ingredients.toList();
  }
}
