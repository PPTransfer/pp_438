import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:pp_438/core/app_export.dart';
import 'package:pp_438/core/services/database/database_service.dart';
import 'package:pp_438/data/models/recipe_model/recipe.dart';
import 'package:pp_438/presentation/home_screen/widget/recipe_main_widget.dart';
import 'package:pp_438/widgets/custom_search_view.dart';

import '../../core/helpers/enums.dart';
import '../../core/helpers/string_helper.dart';
import '../additional_screens/add_recipe_screen.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
  });

  static Widget builder(BuildContext context) {
    return HomeScreen();
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int initialPageIndex = 0;
  List<Recipe> _recipesList = [];
  String selectedCategory = '';
  String searchQuery = '';
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    _recipesList = DatabaseService.getAllRecipes();
  }

  List<Recipe> _getFilteredRecipes() {
    List<Recipe> filteredRecipes = _recipesList;

    if (selectedCategory == 'F') {
      filteredRecipes =
          filteredRecipes.where((quote) => quote.isFavorite == true).toList();
    } else if (selectedCategory.isNotEmpty) {
      filteredRecipes = filteredRecipes
          .where((quote) => quote.category.name == selectedCategory)
          .toList();
    } else {
      filteredRecipes = _recipesList;
    }

    // Фильтрация по поисковому запросу
    if (searchQuery.isNotEmpty) {
      filteredRecipes = filteredRecipes
          .where((recipe) =>
              recipe.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
              recipe.description
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
          .toList();
    }

    return filteredRecipes;
  }

  void _updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: BackgroundWidget(
        
        child: Column(
          children: [
            SizedBox(
              height: 120.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.h),
                  child: Text(
                    'Recipes',
                    style: theme.textTheme.displayLarge,
                  ),
                ),
                InkWell(
                  onTap: () => _onAddRecipeTap(),
                  child: CustomImageView(
                    imagePath: Assets.images.addButton,
                  ),
                ),
              ],
            ),
            Container(
              decoration:
                  AppDecoration.fillBlack900.copyWith(color: appTheme.gray900),
              padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
              child: Row(
                children: [
                  Expanded(
                    child: CustomSearchView(
                      hintText: 'Search',
                      hintStyle: CustomTextStyles.bodyLargeOnPrimary,
                      onChanged: _updateSearchQuery,
                      controller: _searchController,
                      onClearTap: _onClearTap,
                    ),
                  ),
                  SizedBox(
                    width: 8.h,
                  ),
                  Container(
                      height: 45.h,
                      width: 45.h,
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.h, vertical: 8.h),
                      child: _buildCategoryDropdown()),
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Expanded(
              child: _buildRecipeiesList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        customButton: Container(
          child: CustomImageView(
            imagePath:selectedCategory.isNotEmpty? selectedCategory=='F' ?Assets.images.favoriteFill : assetByRecipeCategory(RecipeCategory.values.firstWhere(
                (x) => x.name == selectedCategory,
                orElse: () => RecipeCategory.breakfast)) : Assets.images.filter,
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 100,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
        buttonStyleData: ButtonStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color: Colors.redAccent,
          ),
          elevation: 2,
        ),
        dropdownStyleData: DropdownStyleData(
          width: 250.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: appTheme.gray900,
          ),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
          ),
        ),
        value: selectedCategory,
        items: [
          DropdownMenuItem(
            value: '',
            child: Container(
              decoration: AppDecoration.fillPrimary
                  .copyWith(color: theme.colorScheme.primary),
              padding: EdgeInsets.symmetric(
                horizontal: 8.h,
                vertical: 8.h,
              ),
              child: Row(
                children: [
                  Container(  decoration: AppDecoration.fillBlack.copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
                    child: CustomImageView(
                      height: 60.h,
                      width: 60.h,
                      imagePath:Assets.images.filter,
                    ),
                  ),
                  SizedBox(width: 8.h),
                  Text(
                    'All',
                    style: theme.textTheme.displaySmall,
                  ),
                ],
              ),
            ),
          ),

          ...RecipeCategory.values.map((RecipeCategory category) {
            return DropdownMenuItem<String>(
              value: category.name,
              child: Container(
                decoration: AppDecoration.fillPrimary
                    .copyWith(color: theme.colorScheme.primary),
                padding: EdgeInsets.symmetric(
                  horizontal: 8.h,
                  vertical: 8.h,
                ),
                child: Row(
                  children: [
                    CustomImageView(
                      height: 60.h,
                      width: 60.h,
                      imagePath: assetByRecipeCategory(category),
                    ),
                    SizedBox(width: 8.h),
                    Text(
                      capitalize(category.toString().split('.').last),
                      style: theme.textTheme.displaySmall,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          DropdownMenuItem(
            value: 'F',
            child: Container(
              decoration: AppDecoration.fillPrimary
                  .copyWith(color: theme.colorScheme.primary),
              padding: EdgeInsets.symmetric(
                horizontal: 8.h,
                vertical: 8.h,
              ),
              child: Row(
                children: [
                  Container(
                    decoration: AppDecoration.fillBlack.copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
                    child: CustomImageView(
                      height: 60.h,
                      width: 60.h,
                      imagePath: Assets.images.favoriteFill,
                    ),
                  ),
                  SizedBox(width: 8.h),
                  Text(
                    'Favorites',
                    style: theme.textTheme.displaySmall,
                  ),
                ],
              ),
            ),
          ),
        ],
        onChanged: (String? newValue) {
          setState(() {
            selectedCategory = newValue!;
          });
        },
      ),
    );
  }

  Widget _buildRecipeiesList(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_getFilteredRecipes().isNotEmpty)
            Expanded(
              child: ListView.builder(
                //scrollDirection: Axis.horizontal,

                // shrinkWrap: true,
                //physics: NeverScrollableScrollPhysics(),
                itemCount: _getFilteredRecipes().length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: RecipeMainWidget(
                      recipe: _getFilteredRecipes()[index],
                      onDelete: () => {},
                      //onTapComplete: () => _tasksList = DatabaseService.getAllTasks(),
                    ),
                  );
                },
              ),
            ),
          if (_getFilteredRecipes().isEmpty)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tap on + to create a new\nrecipe ',
                    style: CustomTextStyles.displaySmallOnPrimary,
                    textAlign: TextAlign.center,
                  ),
                  // SizedBox(
                  //   height: 16,
                  // ),
                  CustomImageView(
                    imagePath: Assets.images.recipesEmpty,
                  )
                ],
              ),
            )
        ],
      ),
    );
  }

  void _onAddRecipeTap() {
    context.pushRoute(AddRecipeRoute(recipe: Recipe.empty()));
  }

  void _onTapAddNew() {
    showDialog(
      context: context,
      builder: (context) {
        return AddRecipeScreen(
          recipe: Recipe.empty(),
        );
      },
    );
  }

// _onDeleteTap(int index, Menu menu, RecipeCategory category) async {
//   switch (category) {
//     case RecipeCategory.breakfast:
//       menu.breakfast!.removeAt(index);

//     case RecipeCategory.lunch:
//       menu.lunch!.removeAt(index);

//     case RecipeCategory.dinner:
//       menu.dinner!.removeAt(index);

//     case RecipeCategory.snack:
//       menu.snack!.removeAt(index);
//   }

//   await DatabaseService.saveMenu(menu);
//   _menuList = await DatabaseService.getAllMenus();
//   setState(() {});
// }

  _onClearTap() {
    setState(() {
      _updateSearchQuery('');
      _searchController.clear();
    });
  }
}
