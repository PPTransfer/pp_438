import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pp_438/core/app_export.dart';
import 'package:pp_438/core/helpers/image_helper.dart';
import 'package:pp_438/core/helpers/string_helper.dart';
import 'package:pp_438/core/services/database/database_service.dart';
import 'package:pp_438/data/models/step_model/step_model.dart';
import 'package:pp_438/presentation/view_screens/widgets/ingredient_widget.dart';
import 'package:pp_438/widgets/custom_elevated_button.dart';
import 'package:pp_438/widgets/custom_tab_bar.dart';
import 'package:pp_438/widgets/step_widget.dart';

import '../../core/helpers/enums.dart';
import '../../data/models/ingredient_model/ingredient.dart';
import '../../data/models/recipe_model/recipe.dart';

@RoutePage()
class ChangeRecipeScreen extends StatefulWidget {
  final Recipe recipe;

  const ChangeRecipeScreen({super.key, required this.recipe});

  @override
  State<ChangeRecipeScreen> createState() => _ChangeRecipeScreenState();

  static Widget builder(BuildContext context, Recipe recipe) {
    return ChangeRecipeScreen(recipe: recipe);
  }
}

class _ChangeRecipeScreenState extends State<ChangeRecipeScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  RecipeCategory _selectedCategory = RecipeCategory.breakfast;
  List<Ingredient> _allIngredients = [];
  List<Ingredient> _recipeIngredients = [];
  List<StepModel> _steps = [];
  Uint8List _selectedPhoto = Uint8List(0);
  double _rating = 0.0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    _selectedCategory = widget.recipe.category;
    _allIngredients = DatabaseService.getAllIngredients();
    _rating = widget.recipe.difficult.toDouble();
    _steps = widget.recipe.steps;
    getAllIngredients();
    if (widget.recipe.photo != null)
      _selectedPhoto = ImageHelper.convertBase64ToFile(widget.recipe.photo!);
    super.initState();
  }

  void toggleFavorite(Recipe recipe) {
    setState(() {
      recipe.isFavorite = !recipe.isFavorite;
      DatabaseService.saveRecipe(
          recipe.copyWith(isFavorite: recipe.isFavorite));
    });
  }

  void getAllIngredients() {
    for (StepModel step in _steps) {
      for (String ingredientId in step.ingredientsIdList) {
        _recipeIngredients
            .add(_allIngredients.firstWhere((x) => x.id == ingredientId));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,
     body: BackgroundWidget(
        
        child: Column(
          children: [
            SizedBox(height: 50.h),
            _buildHeader(),
            Expanded(child: _buildContent(context)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 80.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomElevatedButton(
              buttonStyle: CustomButtonStyles.fillRed,
              text: 'Save',
              onPressed: () => _onSaveTap(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: AppDecoration.fillGray,
              child: Row(
                children: [
                   InkWell(
                    onTap: () => context.maybePop(),
                    child: CustomImageView(imagePath: Assets.images.btnBack),
                  ),
                  SizedBox(width: 16.h),
                  Expanded(
                    child: Text('Recipe', style: theme.textTheme.displayLarge),
                  ),
                  SizedBox(width: 16.h),
                ],
              ),
            ),
          ),
          _buildCategoryDropdown(),
        ],
      ),
    );
  }

  int _pageIndex = 0;

  Widget _buildCategoryDropdown() {
    return Container(
      decoration: AppDecoration.fillPrimary
          .copyWith(borderRadius: BorderRadiusStyle.customBorderTL20),
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.h),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<RecipeCategory>(
          customButton: CustomImageView(
            height: 60.h,
            width: 60.h,
            imagePath: assetByRecipeCategory(_selectedCategory),
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
          value: _selectedCategory,
          items: RecipeCategory.values.map((RecipeCategory category) {
            return DropdownMenuItem<RecipeCategory>(
              value: category,
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
          onChanged: (RecipeCategory? newValue) {
            setState(() {
              _selectedCategory = newValue!;
            });
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 16.h),
          _buildRecipeTitle(),
          SizedBox(height: 16.h),
          _buildRecipeDescription(),
          SizedBox(height: 30.h),
          _buildChangePictureAndRating(),
          SizedBox(height: 16.h),
          CustomTabBar(
            tabs: ['Steps', 'Ingredients'],
            controller: _tabController,
            onTap: (value) => setState(() => _pageIndex = value),
          ),
          Expanded(
            child: Column(
              children: [
                if (_pageIndex == 0) Expanded(child: _buildStepTabView()),
                if (_pageIndex == 1)
                  Expanded(child: _buildIngredientsTabView()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeTitle() {
    return Container(
      decoration: AppDecoration.fillPrimaryOpacity,
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
      child: Text(
        widget.recipe.name,
        style: CustomTextStyles.bodyLargeOnPrimary,
      ),
    );
  }

  Widget _buildRecipeDescription() {
    return Container(
      decoration: AppDecoration.fillPrimaryOpacity,
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
      child: Text(
        widget.recipe.description,
        style: CustomTextStyles.bodyLargeOnPrimary,
      ),
    );
  }

  Widget _buildChangePictureAndRating() {
    return Container(
      // decoration: AppDecoration.fillPrimaryOpacity,
      // padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => pickImage(),
            borderRadius: BorderRadiusStyle.roundedBorder30,
            child: Container(
              decoration: AppDecoration.fillPrimary,
              padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 10.h),
              child: Row(
                children: [
                  CustomImageView(
                    imagePath: Assets.images.camera,
                  ),
                  SizedBox(width: 12.h),
                  Text(
                    'Change picture',
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
          RatingBar(
            initialRating: widget.recipe.difficult.toDouble(),
            direction: Axis.horizontal,
            itemCount: 5,
            itemSize: 20.h,
            glowColor: appTheme.red300,
            ratingWidget: RatingWidget(
              full: CustomImageView(imagePath: Assets.images.starFull),
              half: CustomImageView(imagePath: Assets.images.starFull),
              empty: CustomImageView(imagePath: Assets.images.starEmpty),
            ),
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            onRatingUpdate: (rating) {},
          ),
        ],
      ),
    );
  }

  Widget _buildStepTabView() {
    return Column(
      children: [
        SizedBox(height: 16.h),
        CustomElevatedButton(
          buttonStyle: CustomButtonStyles.fillPrimaryTL20,
          onPressed: () => _onAddStepTap(),
          // height: 35.h,
          leftIcon: Icon(
            Icons.add,
            color: theme.colorScheme.surface,
            size: 30.h,
          ),
          //rightIcon: Padding(padding: padding),
          buttonTextStyle: theme.textTheme.displaySmall,
          text: 'add a step',
        ),
        SizedBox(height: 16.h),
        Expanded(
          // height: 500,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _steps.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: StepWidget(
                  step: _steps[index],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 80.h),
      ],
    );
  }

  Widget _buildIngredientsTabView() {
    return Column(
      children: [
        SizedBox(height: 16.h),
        Expanded(
          child: ListView.builder(
            //shrinkWrap: true,

            itemCount: _recipeIngredients.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: IngredientWidget(ingredient: _recipeIngredients[index]),
              );
            },
          ),
        ),
        SizedBox(height: 80.h),
      ],
    );
  }

  void _onAddStepTap() async {
    final step = await context.pushRoute(AddStepRoute(recipe: widget.recipe));

    if (step != null) {
      setState(() {
        widget.recipe.steps.add(step as StepModel);
        _steps = widget.recipe.steps;
      });
    }
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => _selectedPhoto = imageTemp.readAsBytesSync());
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void _onSaveTap(BuildContext context) async {
    Recipe recipe = widget.recipe.copyWith(
      id: widget.recipe.id,
      category: _selectedCategory!,
      difficult: _rating.toInt(),
      steps: widget.recipe.steps,
      photo: _selectedPhoto.isNotEmpty
          ? ImageHelper.convertFileToBase64(_selectedPhoto)
          : widget.recipe.photo,
    );

    await DatabaseService.saveRecipe(recipe);
    context.pushRoute(MainRoute());

    //context.push
  }
}
