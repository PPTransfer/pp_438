import 'package:hive/hive.dart';
import 'package:pp_438/data/models/step_model/step_model.dart';

import '../../../core/helpers/enums.dart';
import '../ingredient_model/ingredient.dart';

part 'recipe.g.dart';

@HiveType(typeId: 0)
class Recipe extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  RecipeCategory category;

  @HiveField(3)
  int difficult;

  @HiveField(4)
  String description;

  @HiveField(5)
  List<Ingredient> ingredients;

  @HiveField(6)
  List<StepModel> steps;
  @HiveField(7)
  String? photo;
  @HiveField(8)
  bool isFavorite;

  Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.difficult,
    required this.description,
    required this.ingredients,
    required this.steps,
    this.photo,
    this.isFavorite = false,
  });

  factory Recipe.empty() => Recipe(
        id: '',
        name: '',
        category: RecipeCategory.lunch,
        difficult: 0,
        description: '',
        ingredients: [],
        steps: [],
        photo: '',
        isFavorite: false,
      );

  Recipe copyWith({
    String? id,
    String? name,
    RecipeCategory? category,
    int? difficult,
    String? description,
    List<Ingredient>? ingredients,
    List<StepModel>? steps,
    String? photo,
    bool? isFavorite,
  }) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      difficult: difficult ?? this.difficult,
      description: description ?? this.description,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      photo: photo ?? this.photo,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
