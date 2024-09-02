import 'package:hive/hive.dart';
import 'package:pp_438/data/models/recipe_model/recipe.dart';

part 'menu.g.dart';  // Needed for Hive type adapter generation

@HiveType(typeId: 5) // Assign a unique typeId for each Hive model
class Menu extends HiveObject {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final List<Recipe>? breakfast;

  @HiveField(2)
  final List<Recipe>? lunch;

  @HiveField(3)
  final List<Recipe>? dinner;

  @HiveField(4)
  final List<Recipe>? snack;

  Menu({
    required this.date,
    this.breakfast,
    this.lunch,
    this.dinner,
    this.snack,
  });

  // Factory constructor for creating an empty Menu
  factory Menu.empty() {
    return Menu(
      date: DateTime.now(),
      breakfast: [],
      lunch: [],
      dinner: [],
      snack: [],
    );
  }

  // CopyWith method
  Menu copyWith({
    DateTime? date,
    List<Recipe>? breakfast,
    List<Recipe>? lunch,
    List<Recipe>? dinner,
    List<Recipe>? snack,
  }) {
    return Menu(
      date: date ?? this.date,
      breakfast: breakfast ?? this.breakfast,
      lunch: lunch ?? this.lunch,
      dinner: dinner ?? this.dinner,
      snack: snack ?? this.snack,
    );
  }
}
