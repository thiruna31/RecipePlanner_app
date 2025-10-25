
class MealPlan {
  final String day;
  final List<String> recipeIds;

  MealPlan({required this.day, required this.recipeIds});

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'recipeIds': recipeIds.join('|'),
    };
  }

  factory MealPlan.fromMap(Map<String, dynamic> map) {
    return MealPlan(
      day: map['day'],
      recipeIds: map['recipeIds'].split('|'),
    );
  }
}
