class Recipe {
  final String id;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final bool isVegan;
  final bool isVegetarian;
  final bool isGlutenFree;
  final bool isNonVeg;

  Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    this.isVegan = false,
    this.isVegetarian = false,
    this.isGlutenFree = false,
    this.isNonVeg = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'ingredients': ingredients.join('|'),
      'steps': steps.join('|'),
      'isVegan': isVegan ? 1 : 0,
      'isVegetarian': isVegetarian ? 1 : 0,
      'isGlutenFree': isGlutenFree ? 1 : 0,
      'isNonVeg': isNonVeg ? 1 : 0,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    bool parseBool(dynamic value) => value == 1 || value == true;
    return Recipe(
      id: map['id'] as String,
      title: map['title'] as String,
      imageUrl: map['imageUrl'] as String,
      ingredients: (map['ingredients'] as String).split('|'),
      steps: (map['steps'] as String).split('|'),
      isVegan: parseBool(map['isVegan'] ?? 0),
      isVegetarian: parseBool(map['isVegetarian'] ?? 0),
      isGlutenFree: parseBool(map['isGlutenFree'] ?? 0),
      isNonVeg: parseBool(map['isNonVeg'] ?? 0),
    );
  }
}
