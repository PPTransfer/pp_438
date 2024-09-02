import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pp_438/core/app_export.dart';
import 'package:pp_438/core/helpers/string_helper.dart';
import 'package:pp_438/data/models/recipe_model/recipe.dart';
import 'package:pp_438/presentation/additional_screens/add_step_screen.dart';
import 'package:pp_438/routes/app_router.dart';
import 'package:pp_438/widgets/app_bar/custom_app_bar.dart';
import 'package:pp_438/widgets/custom_icon_button.dart';
import 'package:pp_438/widgets/custom_tab_bar.dart';
import 'package:pp_438/widgets/custom_text_field_form.dart';

import '../../core/helpers/enums.dart';
import '../../core/services/database/database_service.dart';
import '../../data/models/ingredient_model/ingredient.dart';
import '../../gen/assets.gen.dart';
import '../../widgets/custom_elevated_button.dart';

@RoutePage()
class AddIngredientsScreen extends StatefulWidget {
  final Recipe recipe;

  const AddIngredientsScreen({
    super.key,
    required this.recipe,
  });

  static Widget builder(
    BuildContext context,
    Recipe recipe,
  ) {
    return AddIngredientsScreen(
      recipe: recipe,
    );
  }

  @override
  State<AddIngredientsScreen> createState() => _AddIngredientsScreenState();
}

class _AddIngredientsScreenState extends State<AddIngredientsScreen>
    with TickerProviderStateMixin {
  List<Ingredient> _ingredients = [];

  @override
  void dispose() {
    super.dispose();
  }

  bool _isEdit = false;

  @override
  void initState() {
    super.initState();

    _initializeData();
  }

  Future<void> _initializeData() async {
    if (widget.recipe.id.isNotEmpty) {
      _isEdit = true;
      _ingredients = widget.recipe.ingredients;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidth: 56.h,
        leading: CustomIconButton(
          onTap: () => NavigatorService.goBack(),
          
          child: CustomImageView(
            imagePath: Assets.images.btnBack,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                (_isEdit ? 'Edit' : 'Adds') + '\nthe ingredients',
                style: theme.textTheme.displayLarge,
              ),
              SizedBox(
                height: 20.h,
              ),
              ..._ingredients.asMap().entries.map(
                (entry) {
                  int index = entry.key;
                  Ingredient ingredient = entry.value;
                  return Column(
                    children: [
                      if (_ingredients.indexOf(ingredient) > 0) Divider(),
                      SizedBox(
                        height: 16.h,
                      ),
                      IngredientForm(
                        ingredient: ingredient,
                        isEdit: _isEdit,
                        onDelete: () => _onDeleteStepTap(index),
                        onChanged: (updatedIngredient) {
                          setState(() {
                            int index = _ingredients.indexOf(ingredient);
                            _ingredients[index] = updatedIngredient;
                          });
                        },
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 16),
              SizedBox(height: 120),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen,
        child: ValueListenableBuilder<bool>(
          valueListenable: ValueNotifier(_isFieldsFill()),
          builder: (BuildContext context, bool value, Widget? child) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomElevatedButton(
                    text: _isEdit ? 'Save' : 'Next',
                    isDisabled: !value,
                    onPressed: _onSaveTap,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  bool _isFieldsFill() {
    return (!_ingredients.any((x) =>
        x.name.isEmpty || x.amount == 0 || x.note.isEmpty || x.note.isEmpty));
  }

  void _onDeleteStepTap(int index) {
    setState(() {
      _ingredients.removeAt(index);
    });
  }

  void _onSaveTap() async {
    if (_isFieldsFill()) {
      Recipe recipe = Recipe(
        id: widget.recipe.id,
        name: widget.recipe.name,
        category: widget.recipe.category,
        difficult: widget.recipe.difficult,
        description: widget.recipe.description,
        ingredients: _ingredients,
        steps: widget.recipe.steps,
        photo: widget.recipe.photo,
      );
      if (!_isEdit) {
        showDialog(
          context: context,
          builder: (context) {
            return AddStepScreen(
              recipe: recipe,
            );
          },
        );
      } else {
        await DatabaseService.saveRecipe(recipe);
        context.pushRoute(MainRoute());
      }
      // context.pushRoute(MainRoute())  ;
    }
  }
}

// ignore: must_be_immutable
class IngredientForm extends StatefulWidget {
  final Ingredient ingredient;
  final bool isEdit;
  final Function(Ingredient) onChanged;
  final Function()? onDelete;

  IngredientForm({
    Key? key,
    required this.ingredient,
    required this.onChanged,
    this.isEdit = false,
    this.onDelete,
  });

  @override
  State<IngredientForm> createState() => _IngredientFormState();
}

class _IngredientFormState extends State<IngredientForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _quantitiesController = TextEditingController();
  TextEditingController _noteController = TextEditingController();

  FocusNode _noteNode = FocusNode();
  FocusNode _quantitiesNode = FocusNode();
  FocusNode _nameNode = FocusNode();
  int _selectedCategory = 0;

  @override
  void initState() {
    _initializeData();
    super.initState();
  }

  @override
  void didUpdateWidget(IngredientForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.ingredient != oldWidget.ingredient) {
      _initializeData();
    }
  }

  void _initializeData() {
    if (widget.isEdit) {
      _nameController.text = widget.ingredient.name;
      _quantitiesController.text = widget.ingredient.amount.toStringAsFixed(0);
      _noteController.text = widget.ingredient.note;
      //_selectedCategory = widget.ingredient.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // CustomTextField(
        //   context,
        //   controller: _nameController,
        //   focusNode: _nameNode,
        //   hint: 'Product name',
        //   // decoration: InputDecoration(hintText: 'Ingredient name'),
        //   onChanged: (value) =>
        //       widget.onChanged(widget.ingredient.copyWith(name: value)),
        // ),
        SizedBox(
          height: 8.h,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.h),
          decoration: AppDecoration.primary,
          child: DropdownButton<int>(
              padding: EdgeInsets.all(0),
              //itemHeight: 16.h,
              underline: Container(),
              isExpanded: true,
              value: _selectedCategory,
              items: categoriesList.keys
                  .map((u) => DropdownMenuItem(
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 4.h),
                            decoration: AppDecoration.primary.copyWith(
                              color: _selectedCategory == u
                                  ? colorByCategory(u)
                                  : appTheme.black900,
                              borderRadius: BorderRadiusStyle.roundedBorder30,
                            ),
                            // child: CustomImageView(
                            //   imagePath: imageByCategory(u),
                            // ),
                          ),
                          SizedBox(
                            width: 8.h,
                          ),
                          Text(
                            categoriesList.values.elementAt(u),
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      value: u))
                  .toList(),
              onChanged: (value) {
                _selectedCategory = value!;
              //  widget.onChanged(widget.ingredient.copyWith(category: value));
              }),
        ),
        Text(
          'Quantities',
          style: theme.textTheme.bodyLarge,
        ),
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: _quantitiesController,
                focusNode: _quantitiesNode,
                textInputType: TextInputType.numberWithOptions(),
                hintText: '0',
                // decoration: InputDecoration(hintText: 'Ingredient name'),
                // onChanged: (value) => widget.onChanged(
                //     widget.ingredient.copyWith(amount: double.parse(value!))),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.h),
                decoration: AppDecoration.primary,
                child: DropdownButton<Unit>(
                  padding: EdgeInsets.zero,
                  elevation: 0,
                  underline: Container(),
                  isExpanded: true,
                  value: widget.ingredient.unit,
                  items: Unit.values
                      .map((u) => DropdownMenuItem(
                          child: Text(
                            u.name.toString(),
                            style: theme.textTheme.bodyMedium,
                          ),
                          value: u))
                      .toList(),
                  onChanged: (value) =>
                      widget.onChanged(widget.ingredient.copyWith(unit: value)),
                ),
              ),
            ),
            SizedBox(width: 50.h),
          ],
        ),
        SizedBox(height: 8.h),
        CustomTextFormField(
          maxLines: 3,
          controller: _noteController,
          focusNode: _noteNode,
          //textInputType: TextInputType.numberWithOptions(),
          hintText: 'Note',
          // decoration: InputDecoration(hintText: 'Ingredient name'),
          onChanged: (value) =>
              widget.onChanged(widget.ingredient.copyWith(note: value)),
        ),
        SizedBox(height: 16.h),
        CustomElevatedButton(
          onPressed: () {
            print(widget.ingredient.name);
            widget.onDelete?.call();
          },
          height: 40,
          buttonTextStyle: theme.textTheme.bodyMedium,
          text: 'Delete ingredient',
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
