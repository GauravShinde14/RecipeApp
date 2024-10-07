import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/services/consts.dart';
// Make sure to import your Recipe model here

class DataService {
  String baseUrl = "$API_BASE_URL/recipes";

  Future<List<Recipe>> fetchRecipes() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Recipe> recipes = List<Recipe>.from(
        data['recipes'].map((recipe) => Recipe.fromJson(recipe)),
      );
      // print(recipes);
      return recipes;
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<List<Recipe>> fetchRecipesByFilter(String filter) async {
    if (filter.isNotEmpty) {
      baseUrl = 'https://dummyjson.com/recipes/meal-type/$filter';
    }
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Recipe> recipes = List<Recipe>.from(
        data['recipes'].map((recipe) => Recipe.fromJson(recipe)),
      );
      // print(recipes);
      return recipes;
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
