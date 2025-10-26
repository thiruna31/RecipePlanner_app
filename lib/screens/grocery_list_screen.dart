import 'package:flutter/material.dart';

class GroceryListScreen extends StatefulWidget {
  const GroceryListScreen({super.key});

  @override
  State<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  final List<Map<String, dynamic>> _groceries = [];

  
  final Map<String, String> _imageMap = {
    'burger': 'assets/images/burger.jpg',
    'burrito': 'assets/images/burrito.jpg',
    'chicken_curry': 'assets/images/chicken_curry.jpg',
    'fried_rice': 'assets/images/fried_rice.jpg',
    'fruit_salad': 'assets/images/fruit_salad.jpg',
    'grilled_fish': 'assets/images/grilled_fish.jpg',
    'noodles': 'assets/images/noodles.jpg',
    'omelette': 'assets/images/omelette.jpg',
    'pancakes': 'assets/images/pancakes.jpg',
    'pizza': 'assets/images/pizza.jpg',
    'salad': 'assets/images/salad.jpg',
    'sandwich': 'assets/images/sandwich.jpg',
    'smoothie': 'assets/images/smoothie.jpg',
    'tomato_soup': 'assets/images/tomato_soup.jpg',
    'veggie_pasta': 'assets/images/veggie_pasta.jpg',
  };

  void _addGrocery() {
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Grocery Item'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Item name',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              if (name.isNotEmpty) {
                
                String normalized = name.toLowerCase().replaceAll(' ', '_');
                String image = _imageMap[normalized] ?? _imageMap.values.first;
                setState(() {
                  _groceries.add({
                    'name': name,
                    'image': image,
                  });
                });
              }
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grocery List')),
      body: _groceries.isEmpty
          ? const Center(child: Text('No items added yet!'))
          : ListView.builder(
              itemCount: _groceries.length,
              itemBuilder: (context, index) {
                final item = _groceries[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: ListTile(
                    leading: Image.asset(
                      item['image'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item['name']),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addGrocery,
        icon: const Icon(Icons.add),
        label: const Text('Add Item'),
      ),
    );
  }
}
