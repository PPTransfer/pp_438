// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddIngredientsRoute.name: (routeData) {
      final args = routeData.argsAs<AddIngredientsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddIngredientsScreen(
          key: args.key,
          recipe: args.recipe,
        ),
      );
    },
    AddRecipeRoute.name: (routeData) {
      final args = routeData.argsAs<AddRecipeRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddRecipeScreen(
          key: args.key,
          recipe: args.recipe,
        ),
      );
    },
    AddStepRoute.name: (routeData) {
      final args = routeData.argsAs<AddStepRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddStepScreen(
          key: args.key,
          recipe: args.recipe,
          step: args.step,
        ),
      );
    },
    AgreementRoute.name: (routeData) {
      final args = routeData.argsAs<AgreementRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AgreementScreen(
          key: args.key,
          arguments: args.arguments,
        ),
      );
    },
    ChangeQuantityRoute.name: (routeData) {
      final args = routeData.argsAs<ChangeQuantityRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChangeQuantityScreen(
          key: args.key,
          ingredient: args.ingredient,
        ),
      );
    },
    ChangeRecipeRoute.name: (routeData) {
      final args = routeData.argsAs<ChangeRecipeRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChangeRecipeScreen(
          key: args.key,
          recipe: args.recipe,
        ),
      );
    },
    CookingRoute.name: (routeData) {
      final args = routeData.argsAs<CookingRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CookingScreen(
          key: args.key,
          recipe: args.recipe,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HomeScreen(key: args.key),
      );
    },
    IngredientsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const IngredientsScreen(),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainScreen(),
      );
    },
    NoteRoute.name: (routeData) {
      final args = routeData.argsAs<NoteRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NoteScreen(
          key: args.key,
          note: args.note,
        ),
      );
    },
    OnboardingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OnboardingScreen(),
      );
    },
    PrivacyRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PrivacyScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      final args = routeData.argsAs<SettingsRouteArgs>(
          orElse: () => const SettingsRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SettingsScreen(key: args.key),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
    ViewRecipeRoute.name: (routeData) {
      final args = routeData.argsAs<ViewRecipeRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ViewRecipeScreen(
          key: args.key,
          recipe: args.recipe,
        ),
      );
    },
    ViewRecipesListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ViewRecipesListScreen(),
      );
    },
  };
}

/// generated route for
/// [AddIngredientsScreen]
class AddIngredientsRoute extends PageRouteInfo<AddIngredientsRouteArgs> {
  AddIngredientsRoute({
    Key? key,
    required Recipe recipe,
    List<PageRouteInfo>? children,
  }) : super(
          AddIngredientsRoute.name,
          args: AddIngredientsRouteArgs(
            key: key,
            recipe: recipe,
          ),
          initialChildren: children,
        );

  static const String name = 'AddIngredientsRoute';

  static const PageInfo<AddIngredientsRouteArgs> page =
      PageInfo<AddIngredientsRouteArgs>(name);
}

class AddIngredientsRouteArgs {
  const AddIngredientsRouteArgs({
    this.key,
    required this.recipe,
  });

  final Key? key;

  final Recipe recipe;

  @override
  String toString() {
    return 'AddIngredientsRouteArgs{key: $key, recipe: $recipe}';
  }
}

/// generated route for
/// [AddRecipeScreen]
class AddRecipeRoute extends PageRouteInfo<AddRecipeRouteArgs> {
  AddRecipeRoute({
    Key? key,
    required Recipe recipe,
    List<PageRouteInfo>? children,
  }) : super(
          AddRecipeRoute.name,
          args: AddRecipeRouteArgs(
            key: key,
            recipe: recipe,
          ),
          initialChildren: children,
        );

  static const String name = 'AddRecipeRoute';

  static const PageInfo<AddRecipeRouteArgs> page =
      PageInfo<AddRecipeRouteArgs>(name);
}

class AddRecipeRouteArgs {
  const AddRecipeRouteArgs({
    this.key,
    required this.recipe,
  });

  final Key? key;

  final Recipe recipe;

  @override
  String toString() {
    return 'AddRecipeRouteArgs{key: $key, recipe: $recipe}';
  }
}

/// generated route for
/// [AddStepScreen]
class AddStepRoute extends PageRouteInfo<AddStepRouteArgs> {
  AddStepRoute({
    Key? key,
    required Recipe recipe,
    StepModel? step,
    List<PageRouteInfo>? children,
  }) : super(
          AddStepRoute.name,
          args: AddStepRouteArgs(
            key: key,
            recipe: recipe,
            step: step,
          ),
          initialChildren: children,
        );

  static const String name = 'AddStepRoute';

  static const PageInfo<AddStepRouteArgs> page =
      PageInfo<AddStepRouteArgs>(name);
}

class AddStepRouteArgs {
  const AddStepRouteArgs({
    this.key,
    required this.recipe,
    this.step,
  });

  final Key? key;

  final Recipe recipe;

  final StepModel? step;

  @override
  String toString() {
    return 'AddStepRouteArgs{key: $key, recipe: $recipe, step: $step}';
  }
}

/// generated route for
/// [AgreementScreen]
class AgreementRoute extends PageRouteInfo<AgreementRouteArgs> {
  AgreementRoute({
    Key? key,
    required AgreementScreenArguments arguments,
    List<PageRouteInfo>? children,
  }) : super(
          AgreementRoute.name,
          args: AgreementRouteArgs(
            key: key,
            arguments: arguments,
          ),
          initialChildren: children,
        );

  static const String name = 'AgreementRoute';

  static const PageInfo<AgreementRouteArgs> page =
      PageInfo<AgreementRouteArgs>(name);
}

class AgreementRouteArgs {
  const AgreementRouteArgs({
    this.key,
    required this.arguments,
  });

  final Key? key;

  final AgreementScreenArguments arguments;

  @override
  String toString() {
    return 'AgreementRouteArgs{key: $key, arguments: $arguments}';
  }
}

/// generated route for
/// [ChangeQuantityScreen]
class ChangeQuantityRoute extends PageRouteInfo<ChangeQuantityRouteArgs> {
  ChangeQuantityRoute({
    Key? key,
    required Ingredient ingredient,
    List<PageRouteInfo>? children,
  }) : super(
          ChangeQuantityRoute.name,
          args: ChangeQuantityRouteArgs(
            key: key,
            ingredient: ingredient,
          ),
          initialChildren: children,
        );

  static const String name = 'ChangeQuantityRoute';

  static const PageInfo<ChangeQuantityRouteArgs> page =
      PageInfo<ChangeQuantityRouteArgs>(name);
}

class ChangeQuantityRouteArgs {
  const ChangeQuantityRouteArgs({
    this.key,
    required this.ingredient,
  });

  final Key? key;

  final Ingredient ingredient;

  @override
  String toString() {
    return 'ChangeQuantityRouteArgs{key: $key, ingredient: $ingredient}';
  }
}

/// generated route for
/// [ChangeRecipeScreen]
class ChangeRecipeRoute extends PageRouteInfo<ChangeRecipeRouteArgs> {
  ChangeRecipeRoute({
    Key? key,
    required Recipe recipe,
    List<PageRouteInfo>? children,
  }) : super(
          ChangeRecipeRoute.name,
          args: ChangeRecipeRouteArgs(
            key: key,
            recipe: recipe,
          ),
          initialChildren: children,
        );

  static const String name = 'ChangeRecipeRoute';

  static const PageInfo<ChangeRecipeRouteArgs> page =
      PageInfo<ChangeRecipeRouteArgs>(name);
}

class ChangeRecipeRouteArgs {
  const ChangeRecipeRouteArgs({
    this.key,
    required this.recipe,
  });

  final Key? key;

  final Recipe recipe;

  @override
  String toString() {
    return 'ChangeRecipeRouteArgs{key: $key, recipe: $recipe}';
  }
}

/// generated route for
/// [CookingScreen]
class CookingRoute extends PageRouteInfo<CookingRouteArgs> {
  CookingRoute({
    Key? key,
    required Recipe recipe,
    List<PageRouteInfo>? children,
  }) : super(
          CookingRoute.name,
          args: CookingRouteArgs(
            key: key,
            recipe: recipe,
          ),
          initialChildren: children,
        );

  static const String name = 'CookingRoute';

  static const PageInfo<CookingRouteArgs> page =
      PageInfo<CookingRouteArgs>(name);
}

class CookingRouteArgs {
  const CookingRouteArgs({
    this.key,
    required this.recipe,
  });

  final Key? key;

  final Recipe recipe;

  @override
  String toString() {
    return 'CookingRouteArgs{key: $key, recipe: $recipe}';
  }
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<HomeRouteArgs> page = PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [IngredientsScreen]
class IngredientsRoute extends PageRouteInfo<void> {
  const IngredientsRoute({List<PageRouteInfo>? children})
      : super(
          IngredientsRoute.name,
          initialChildren: children,
        );

  static const String name = 'IngredientsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NoteScreen]
class NoteRoute extends PageRouteInfo<NoteRouteArgs> {
  NoteRoute({
    Key? key,
    required String note,
    List<PageRouteInfo>? children,
  }) : super(
          NoteRoute.name,
          args: NoteRouteArgs(
            key: key,
            note: note,
          ),
          initialChildren: children,
        );

  static const String name = 'NoteRoute';

  static const PageInfo<NoteRouteArgs> page = PageInfo<NoteRouteArgs>(name);
}

class NoteRouteArgs {
  const NoteRouteArgs({
    this.key,
    required this.note,
  });

  final Key? key;

  final String note;

  @override
  String toString() {
    return 'NoteRouteArgs{key: $key, note: $note}';
  }
}

/// generated route for
/// [OnboardingScreen]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PrivacyScreen]
class PrivacyRoute extends PageRouteInfo<void> {
  const PrivacyRoute({List<PageRouteInfo>? children})
      : super(
          PrivacyRoute.name,
          initialChildren: children,
        );

  static const String name = 'PrivacyRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<SettingsRouteArgs> {
  SettingsRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SettingsRoute.name,
          args: SettingsRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<SettingsRouteArgs> page =
      PageInfo<SettingsRouteArgs>(name);
}

class SettingsRouteArgs {
  const SettingsRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SettingsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ViewRecipeScreen]
class ViewRecipeRoute extends PageRouteInfo<ViewRecipeRouteArgs> {
  ViewRecipeRoute({
    Key? key,
    required Recipe recipe,
    List<PageRouteInfo>? children,
  }) : super(
          ViewRecipeRoute.name,
          args: ViewRecipeRouteArgs(
            key: key,
            recipe: recipe,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewRecipeRoute';

  static const PageInfo<ViewRecipeRouteArgs> page =
      PageInfo<ViewRecipeRouteArgs>(name);
}

class ViewRecipeRouteArgs {
  const ViewRecipeRouteArgs({
    this.key,
    required this.recipe,
  });

  final Key? key;

  final Recipe recipe;

  @override
  String toString() {
    return 'ViewRecipeRouteArgs{key: $key, recipe: $recipe}';
  }
}

/// generated route for
/// [ViewRecipesListScreen]
class ViewRecipesListRoute extends PageRouteInfo<void> {
  const ViewRecipesListRoute({List<PageRouteInfo>? children})
      : super(
          ViewRecipesListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ViewRecipesListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
