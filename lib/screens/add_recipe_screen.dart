import 'package:flutter/material.dart';
import '../services/db_service.dart';
import '../models/recipe.dart';
import 'package:uuid/uuid.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _stepsController = TextEditingController();
  bool _isVegan = false;
  bool _isVegetarian = false;
  bool _isGlutenFree = false;
  bool _isNonVeg = false;

  Future<void> _saveRecipe() async {
    if (_formKey.currentState!.validate()) {
      final recipe = Recipe(
        id: const Uuid().v4(),
        title: _titleController.text.trim(),
        imageUrl: '', 
        ingredients: _ingredientsController.text.trim().split(',').map((s) => s.trim()).toList(),
        steps: _stepsController.text.trim().split
