import 'package:flutter/material.dart';
import 'screens/recipe_list_screen.dart';
import 'screens/favourites_screen.dart';
import 'screens/meal_planner_screen.dart';
import 'screens/grocery_list_screen.dart';
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
  ThemeMode _themeMode = ThemeMode.light; // Start with light mode (white)

  final List<Widget> _screens = [
    const RecipeListScreen(),
    const FavouritesScreen(),
    const MealPlannerScreen(),
    const GroceryListScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe Planner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal, brightness: Brightness.light),
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 2,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal, brightness: Brightness.dark),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 2,
        ),
        cardTheme: CardThemeData(
          color: Color(0xFF232323),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        useMaterial3: true,
      ),
      themeMode: _themeMode,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Recipe & Meal Planner'),
          actions: [
            IconButton(
              icon: Icon(_themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode),
              tooltip: 'Toggle Theme',
              onPressed: _toggleTheme,
            ),
          ],
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _screens[_selectedIndex],
        ),
        floatingActionButton: _selectedIndex == 0
            ? FloatingActionButton(
                onPressed: () {
                  // Implement Add Recipe navigation
                },
                backgroundColor: Colors.teal,
                child: const Icon(Icons.add, color: Colors.white),
              )
            : null,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt), label: 'Recipes'),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favourites'),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Planner'),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Groceries'),
          ],
        ),
      ),
    );
  }
}
