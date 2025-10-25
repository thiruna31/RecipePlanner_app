import '../models/recipe.dart';

class Filters {
  static bool apply(Recipe r, bool vegan, bool vegetarian, bool glutenFree) {
    if (vegan && !r.isVegan) return false;
    if (vegetarian && !r.isVegetarian) return false;
    if (glutenFree && !r.isGlutenFree) return false;
    return true;
  }
}
