import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/recipe.dart';

class DBService {
  static Database? _db;

 
  static Future<void> init() async {
    final dbPath = await getDatabasesPath();
    _db = await openDatabase(
      join(dbPath, 'recipes.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE recipes (
            id TEXT PRIMARY KEY,
            title TEXT,
            imageUrl TEXT,
            ingredients TEXT,
            steps TEXT,
            isVegan INTEGER,
            isVegetarian INTEGER,
            isGlutenFree INTEGER,
            isNonVeg INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE favourites (
            id TEXT PRIMARY KEY,
            title TEXT,
            imageUrl TEXT,
            ingredients TEXT,
            steps TEXT,
            isVegan INTEGER,
            isVegetarian INTEGER,
            isGlutenFree INTEGER,
            isNonVeg INTEGER
          )
        ''');
      },
    );
  }

  

  static Future<void> addRecipe(Recipe recipe) async {
    if (_db == null) await init();
    await _db!.insert(
      'recipes',
      recipe.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Recipe>> getAllRecipes() async {
    if (_db == null) await init();
    final List<Map<String, dynamic>> maps = await _db!.query('recipes');
    return maps.map((e) => Recipe.fromMap(e)).toList();
  }

  static Future<void> deleteRecipe(String id) async {
    if (_db == null) await init();
    await _db!.delete('recipes', where: 'id = ?', whereArgs: [id]);
  }

  

  static Future<void> addFavourite(Recipe recipe) async {
    if (_db == null) await init();
    await _db!.insert(
      'favourites',
      recipe.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> removeFavourite(String id) async {
    if (_db == null) await init();
    await _db!.delete('favourites', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Recipe>> getFavourites() async {
    if (_db == null) await init();
    final List<Map<String, dynamic>> maps = await _db!.query('favourites');
    return maps.map((e) => Recipe.fromMap(e)).toList();
  }

 
}
