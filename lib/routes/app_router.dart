import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pp_438/presentation/additional_screens/add_recipe_screen.dart';
import 'package:pp_438/presentation/cooking_screen/cooking_screen.dart';
import '../data/models/ingredient_model/ingredient.dart';
import '../data/models/recipe_model/recipe.dart';
import '../data/models/step_model/step_model.dart';
import '../presentation/additional_screens/add_ingredients_screen.dart';
import '../presentation/additional_screens/add_step_screen.dart';
import '../presentation/additional_screens/change_quantity_screen.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/ingredients_screen/ingredients_screen.dart';
import '../presentation/main_screen/main_screen.dart';
import '../presentation/note_screen/note_screen.dart';
import '../presentation/onboarding_screen/onboarding_screen.dart';
import '../presentation/privacy_splash_screen/privacy_view.dart';
import '../presentation/privacy_splash_screen/splash_view.dart';
import '../presentation/settings_screen/agreement_screen/agreement_screen.dart';
import '../presentation/settings_screen/settings_screen.dart';
import '../presentation/additional_screens/change_recipe_screen.dart';
import '../presentation/view_screens/view_recipe_screen.dart';
import '../presentation/view_screens/view_recipes_list_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: PrivacyRoute.page),
    AutoRoute(page: OnboardingRoute.page),
    AutoRoute(page: MainRoute.page, children: [
      AutoRoute(page: HomeRoute.page),
      AutoRoute(page: IngredientsRoute.page),
      AutoRoute(page: SettingsRoute.page),
    ] ),
    AutoRoute(page: AddIngredientsRoute.page),
    AutoRoute(page: AddRecipeRoute.page),
    AutoRoute(page: AddStepRoute.page),
    AutoRoute(page: AgreementRoute.page),
    AutoRoute(page: ViewRecipeRoute.page),
    AutoRoute(page: ChangeRecipeRoute.page),
    AutoRoute(page: CookingRoute.page),
    AutoRoute(page: ChangeQuantityRoute.page),
    AutoRoute(page: NoteRoute.page),
  ];
}