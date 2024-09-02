import 'package:flutter/material.dart';
import 'package:pp_438/core/app_export.dart';
import 'package:pp_438/core/helpers/enums.dart';
import 'package:pp_438/core/helpers/string_helper.dart';
import 'package:pp_438/core/services/database/database_service.dart';
import 'package:pp_438/data/models/recipe_model/recipe.dart';
import 'package:pp_438/presentation/view_screens/widgets/recipe_my_widget.dart';
import 'package:pp_438/widgets/custom_elevated_button.dart';
import 'package:pp_438/widgets/custom_icon_button.dart';

import '../../gen/assets.gen.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_text_field_form.dart';
import '../additional_screens/add_recipe_screen.dart';
@RoutePage()
class ViewRecipesListScreen extends StatefulWidget {
  const ViewRecipesListScreen({
    super.key,
  });

  static Widget builder(
    BuildContext context,
  ) {
    return ViewRecipesListScreen();
  }

  @override
  State<ViewRecipesListScreen> createState() => _ViewRecipesListScreenState();
}

class _ViewRecipesListScreenState extends State<ViewRecipesListScreen> {
  List<Recipe> _recipes = [];
  Set<RecipeCategory> allCategories = {};
  String selectedCategory = '';
  String searchQuery = '';
  @override
  void initState() {
   
    super.initState();
     _recipes = DatabaseService.getAllRecipes();
  }

  List<Recipe> _getFilteredRecipes() {
    List<Recipe> filteredRecipes = _recipes;

    if (selectedCategory == 'F') {
      filteredRecipes =
          filteredRecipes.where((quote) => quote.isFavorite == true).toList();
    } else if (selectedCategory.isNotEmpty) {
      filteredRecipes = filteredRecipes
          .where((quote) => quote.category.name == selectedCategory)
          .toList();
    } else {
      filteredRecipes = _recipes;
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

      appBar: CustomAppBar(
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomIconButton(
                height: 30.h,
                width: 30.h,
                onTap: () => NavigatorService.goBack(),
                
                child: CustomImageView(
                  imagePath: Assets.images.btnBack,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 8.h),
                decoration: AppDecoration.primary.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                ),
                child: InkWell(
                  onTap: ()=>_onAddNewTap(),
                  child: Text(
                    'Add new',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(
              'My recipes',
              style: theme.textTheme.displayLarge,
            ),
            SizedBox(
              height: 16.h,
            ),
            CustomTextFormField(
              contentPadding: EdgeInsets.all(2),
              boxDecoration: AppDecoration.primary
                  .copyWith(borderRadius: BorderRadiusStyle.roundedBorder30),
              prefix: Icon(Icons.search),
              hintText: 'Search',
              hintStyle: theme.textTheme.bodyMedium?.copyWith(
                color: appTheme.gray900,
                fontWeight: FontWeight.w400,
              ),
              onChanged: _updateSearchQuery,
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              //height: 50.h,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.h),
                    child: FilterChip(
                      padding: EdgeInsets.symmetric(horizontal: 8.h),
                      label: Text('All'),
                      selected: selectedCategory == '',
                      onSelected: (value) {
                        setState(() {
                          selectedCategory = '';
                        });
                      },
                      showCheckmark: false,
                      labelStyle: theme.textTheme.bodyMedium,
                      shadowColor: Colors.transparent,
                      disabledColor: theme.colorScheme.surface,
                      selectedColor: appTheme.gray900,
                      side: BorderSide(color: appTheme.gray900),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusStyle.roundedBorder30,
                      ),
                    ),
                  ),
                  ...RecipeCategory.values
                      .map((category) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: FilterChip(
                              padding: EdgeInsets.symmetric(horizontal: 8.h),
                              label: Text(capitalize(category.name)),
                              selected: selectedCategory == category.name,
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    selectedCategory = (category.name);
                                  }
                                });
                              },
                              showCheckmark: false,
                              labelStyle: theme.textTheme.bodyMedium,
                              shadowColor: Colors.transparent,
                              disabledColor: theme.colorScheme.surface,
                              selectedColor: appTheme.gray900,
                              side: BorderSide(color: appTheme.gray900),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusStyle.roundedBorder30,
                              ),
                            ),
                          ))
                      .toList(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.h),
                    child: FilterChip(
                      padding: EdgeInsets.symmetric(horizontal: 8.h),
                      label: CustomImageView(
                        height: 20,
                        imagePath: selectedCategory == 'F'
                            ? Assets.images.favoriteFill
                            : Assets.images.favoriteEmpty,
                      ),
                      selected: selectedCategory == 'F',
                      onSelected: (value) {
                        setState(() {
                          selectedCategory = 'F';
                        });
                      },
                      showCheckmark: false,
                      shadowColor: Colors.transparent,
                      disabledColor: theme.colorScheme.surface,
                      selectedColor: appTheme.gray900,
                      side: BorderSide(color: appTheme.gray900),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusStyle.roundedBorder30,
                      ),
                    ),
                  ),
                ]),
              ),

            ),
            SizedBox(
              height: 8.h,
            ),
           
           _buildRecipesList(context)
          ],
        ),
      ),
    );
  }

  Widget _buildRecipesList(BuildContext context)
  {
    if(_getFilteredRecipes().isEmpty)
    {
      return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.h),
      child: Column(
        children: [
          CustomImageView(
            imagePath: Assets.images.ingredientEmpty,
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            'You haven\'t added \na menu for today',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge,
          ),
          Text(
            'Press + to add ',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
    } 

    return  Expanded(
              child: ListView.builder(
               // shrinkWrap: true,
                itemCount: _getFilteredRecipes().length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: RecipeMyWidget(
                      recipe: _getFilteredRecipes()[index],
                      //onTapComplete: () => _tasksList = DatabaseService.getAllTasks(),
                    ),
                  );
                },
              ),
            );
  }
  
 void _onAddNewTap() {

  showDialog(
        context: context,
        builder: (context) {
          return AddRecipeScreen(
            recipe: Recipe.empty(),
          );
        },
      );
 }
}
