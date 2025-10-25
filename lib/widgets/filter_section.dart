import 'package:flutter/material.dart';

class FilterSection extends StatelessWidget {
  final bool vegan;
  final bool vegetarian;
  final bool glutenFree;
  final Function(bool, bool, bool) onChanged;

  const FilterSection({
    super.key,
    required this.vegan,
    required this.vegetarian,
    required this.glutenFree,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FilterChip(
          label: const Text('Vegan'),
          selected: vegan,
          onSelected: (v) => onChanged(v, vegetarian, glutenFree),
        ),
        FilterChip(
          label: const Text('Vegetarian'),
          selected: vegetarian,
          onSelected: (v) => onChanged(vegan, v, glutenFree),
        ),
        FilterChip(
          label: const Text('Gluten-free'),
          selected: glutenFree,
          onSelected: (v) => onChanged(vegan, vegetarian, v),
        ),
      ],
    );
  }
}
