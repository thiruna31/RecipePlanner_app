class Recipe {
  final String id;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final bool isVegan;
  final bool isVegetarian;
  final bool isGlutenFree;

  Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    this.isVegan = false,
    this.isVegetarian = false,
    this.isGlutenFree = false,
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
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'],
      title: map['title'],
      imageUrl: map['imageUrl'],
      ingredients: map['ingredients'].split('|'),
      steps: map['steps'].split('|'),
      isVegan: map['isVegan'] == 1,
      isVegetarian: map['isVegetarian'] == 1,
      isGlutenFree: map['isGlutenFree'] == 1,
    );
  }
}
