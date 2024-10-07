import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/services/data_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  String _mealType = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipe Book"),
        centerTitle: true,
      ),
      body: SafeArea(child: _buildUI()),
    );
  }

  // This function is moved inside the state class
  Widget _buildUI() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [_recipeTypeButtons(), _recipeList()],
      ),
    );
  }

  // Modified this function to use ListView directly
  // Modified this function to use ListView directly
  Widget _recipeTypeButtons() {
    return SizedBox(
      height: 40, // Set a height for the horizontal ListView
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    _mealType = "snack";
                  });
                },
                child: const Text("Snack")),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    _mealType = "breakfast";
                  });
                },
                child: const Text("Breakfast")),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    _mealType = "lunch";
                  });
                },
                child: const Text("Lunch")),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    _mealType = "dinner";
                  });
                },
                child: const Text("Dinner")),
          ),
        ],
      ),
    );
  }

  Widget _recipeList() {
    return Expanded(
      child: FutureBuilder(
          future: DataService().fetchRecipesByFilter(_mealType),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text("unable to load data"),
              );
            }

            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Recipe recipe = snapshot.data![index];
                  return ListTile(
                    contentPadding: const EdgeInsets.only(top: 20),
                    title: Text(recipe.name),
                    isThreeLine: true,
                    leading: Image.network(recipe.image),
                    subtitle: Text(
                        "${recipe.cuisine}\nDificulty: ${recipe.difficulty}"),
                    trailing: Text("${recipe.rating.toString()} ⭐",
                        style: const TextStyle(fontSize: 15)),
                  );
                });
          }),
    );
  }
}
