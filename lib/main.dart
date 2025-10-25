import 'package:flutter/material.dart';
import 'screens/recipe_list_screen.dart';
import 'screens/favourites_screen.dart';
import 'screens/meal_planner_screen.dart';
import 'services/db_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBService.init();
  runApp(const RecipeApp());
}

class RecipeApp extends StatefulWidget {
  const RecipeApp({super.key});

  @override
  State<RecipeApp> createState() => _RecipeAppState();
}

class _RecipeAppState extends State<RecipeApp> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    RecipeListScreen(),
    FavouritesScreen(),
    MealPlannerScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Planner',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Recipe & Meal Planner')),
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Recipes'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favourites'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Planner'),
          ],
        ),
      ),
    );
  }
}
