import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pp_438/data/models/icon_model/icon_model.dart';
import 'package:pp_438/data/models/ingredient_model/ingredient.dart';
import 'package:pp_438/data/models/recipe_model/recipe.dart';
import 'package:pp_438/data/models/step_model/step_model.dart';
import 'package:uuid/uuid.dart';

import '../../../gen/assets.gen.dart';
import '../../helpers/enums.dart';

class DatabaseService {
  late final Box _common;
  static late final Box<Recipe> _recipesBox;
  static late final Box<Ingredient> _ingredientsBox;
  static late final Box<IconModel> _iconsBox;

  // Инициализация Hive
  Future<DatabaseService> init() async {
    try {
      final appDirectory = await getApplicationDocumentsDirectory();
      Hive.init(appDirectory.path);

      // Register Hive adapters
      Hive.registerAdapter(IngredientAdapter());
      Hive.registerAdapter(RecipeCategoryAdapter());
      Hive.registerAdapter(RecipeAdapter());
      Hive.registerAdapter(StepModelAdapter());
      Hive.registerAdapter(IconModelAdapter());
      Hive.registerAdapter(UnitAdapter());

      // Open boxes
      _common = await Hive.openBox('common');
      await Hive.openBox('iconsBox');
      _recipesBox = await Hive.openBox<Recipe>('recipes');
      _ingredientsBox = await Hive.openBox<Ingredient>('ingredients');
      _iconsBox = await Hive.openBox<IconModel>('icons');

      initializeIcons();
      return this;
    } catch (e, stackTrace) {
      print('Error initializing database: $e');
      print('Stack trace: $stackTrace');
      // Можно добавить логику для обработки ошибки, например:
      // throw DatabaseInitializationException('Failed to initialize database: $e');
      rethrow;
    }
  }

  void put(String key, dynamic value) => _common.put(key, value);

  dynamic get(String key) => _common.get(key);
  static List<String> defaultIconPaths = [
    Assets.images.iconWater,
    Assets.images.iconSalt,
    Assets.images.iconMilk,
    Assets.images.iconLemon,
    Assets.images.iconCheese,
    Assets.images.iconMeat,
    Assets.images.iconChiken,
    Assets.images.iconOil,
    Assets.images.iconFish,
    Assets.images.iconPoridge,
    Assets.images.iconBread,
    Assets.images.iconSpice,
    Assets.images.iconTomato,
    Assets.images.iconCocumber,
    Assets.images.iconPotato,
    Assets.images.iconFlour,
    Assets.images.iconVeg,
    Assets.images.iconGreen,
    Assets.images.iconApple,
    Assets.images.iconPot,
    Assets.images.iconBanana,
    Assets.images.iconFruit,
    Assets.images.iconOrange,
    Assets.images.iconBerry,
    Assets.images.iconCoffie,
    Assets.images.iconChok,
    Assets.images.iconNut,
    Assets.images.iconTea,
    Assets.images.iconCereal,
    Assets.images.iconShugar,
    Assets.images.iconPreserves,
    Assets.images.iconEgg,
    Assets.images.iconPasta,
  ];

  static List<IconModel> getAllIcons()
  {
    final box = _iconsBox;
    return box.values.toList();
  }


  static void initializeIcons() {
    if (_iconsBox.isEmpty) {
      for (var path in defaultIconPaths) {
        _iconsBox.add(IconModel(path: path, isDefault: true));
      }
    }
  }

  static void addCustomIcon(String path) {
    _iconsBox.add(IconModel(path: path, isDefault: false));
  }

 static void deleteCustomIcon(int index) {
    if (!_iconsBox.getAt(index)!.isDefault) {
      _iconsBox.deleteAt(index);
    }
  }


  static List<Ingredient> getAllIngredients() {
    final box = _ingredientsBox;
    return box.values.toList();
  }

  static Future<void> saveIngredient(Ingredient ingredient) async {
    final box = _ingredientsBox;

    if (ingredient.id.isEmpty) {
      final newRecipe = ingredient.copyWith(id: Uuid().v4());
      await box.add(newRecipe);
    } else {
      final index =
          box.values.toList().indexWhere((q) => q.id == ingredient.id);
      if (index != -1) {
        await box.putAt(index, ingredient);
      } else {
        await box.add(ingredient);
      }
    }
  }

  static Future<void> deleteIngredient(String id) async {
    final box = _ingredientsBox;
    final index = box.values.toList().indexWhere((q) => q.id == id);
    if (index != -1) {
      await box.deleteAt(index);
    }
  }

  static List<Recipe> getAllRecipes() {
    final box = _recipesBox;
    return box.values.toList();
  }

  static Future<void> saveRecipe(Recipe recipe) async {
    final box = _recipesBox;
    if (recipe.id.isEmpty) {
      final newRecipe = recipe.copyWith(id: Uuid().v4());
      await box.add(newRecipe);
    } else {
      final index = box.values.toList().indexWhere((q) => q.id == recipe.id);
      if (index != -1) {
        await box.putAt(index, recipe);
      } else {
        await box.add(recipe);
      }
    }
  }

  static Future<void> deleteRecipe(String id) async {
    final box = _recipesBox;
    final index = box.values.toList().indexWhere((q) => q.id == id);
    if (index != -1) {
      await box.deleteAt(index);
    }
  }
}
