import 'package:flutter/material.dart';
import 'package:pp_438/data/models/ingredient_model/ingredient.dart';
import 'package:pp_438/presentation/additional_screens/choose_icon_screen.dart';
import 'package:pp_438/presentation/view_screens/widgets/ingredient_widget.dart';

import '../../core/app_export.dart';
import '../../core/services/database/database_service.dart';
import '../../widgets/custom_search_view.dart';

@RoutePage()
class IngredientsScreen extends StatefulWidget {
  const IngredientsScreen({super.key});

  @override
  State<IngredientsScreen> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  List<Ingredient> _ingredients = [];
  String searchQuery = '';
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    _ingredients = DatabaseService.getAllIngredients();
    print(_ingredients.length);
    setState(() {});
  }

  List<Ingredient> _getFilteredIngredients() {
    List<Ingredient> filteredIngredients = _ingredients;

    // Фильтрация по поисковому запросу
    if (searchQuery.isNotEmpty) {
      filteredIngredients = filteredIngredients
          .where((recipe) =>
              recipe.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
              recipe.note.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    return filteredIngredients;
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
                    'Ingredients',
                    style: theme.textTheme.displayLarge,
                  ),
                ),
                InkWell(
                  onTap: () => _onTapAddNew(),
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
                    child: InkWell(
                     // onTap: ()=>context.pushRoute(ChooseIconScreen),
                      child: Container(
                        decoration: AppDecoration.outlineGray.copyWith(
                          color: appTheme.gray900,
                          border: Border.all(
                            color: theme.colorScheme.primary.withOpacity(0.62),
                          ),
                          borderRadius: BorderRadiusStyle.roundedBorder10,
                        ),
                        padding: EdgeInsets.all(8.h),
                        child: CustomImageView(
                          imagePath: Assets.images.imgBoxFill,
                        ),
                      ),
                    ),
                  ),
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

  Widget _buildRecipeiesList(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_getFilteredIngredients().isNotEmpty)
            Expanded(
              child: ListView.builder(
                //scrollDirection: Axis.horizontal,

                // shrinkWrap: true,
                //physics: NeverScrollableScrollPhysics(),
                itemCount: _getFilteredIngredients().length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: IngredientWidget(
                      ingredient: _getFilteredIngredients()[index],
                      showCount: false,

                      //onTapComplete: () => _tasksList = DatabaseService.getAllTasks(),
                    ),
                  );
                },
              ),
            ),
          if (_getFilteredIngredients().isEmpty)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tap on + to add a new\ningridient ',
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

  _onClearTap() {
    setState(() {
      _updateSearchQuery('');
      _searchController.clear();
    });
  }

  _onTapAddNew() {
    context.pushRoute(AddIngredientsRoute());
  }
}
