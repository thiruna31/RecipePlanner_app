import '../models/recipe.dart';

final List<Recipe> sampleRecipes = [
  Recipe(
    id: '1',
    title: 'Veggie Pasta',
    imageUrl: 'https://picsum.photos/200/300',
    ingredients: ['Pasta', 'Tomatoes', 'Basil', 'Olive Oil'],
    steps: ['Boil pasta', 'Prepare sauce', 'Mix and serve'],
    isVegan: true,
    isVegetarian: true,
  ),
  Recipe(
    id: '2',
    title: 'Chicken Curry',
    imageUrl: 'https://picsum.photos/201/300',
    ingredients: ['Chicken', 'Curry powder', 'Onions', 'Garlic'],
    steps: ['Cook chicken', 'Add spices', 'Simmer until done'],
  ),
];
