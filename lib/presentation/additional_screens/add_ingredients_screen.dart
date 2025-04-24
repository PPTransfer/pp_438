import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pp_438/core/app_export.dart';
import 'package:pp_438/core/helpers/string_helper.dart';
import 'package:pp_438/data/models/recipe_model/recipe.dart';
import 'package:pp_438/presentation/additional_screens/add_step_screen.dart';
import 'package:pp_438/presentation/additional_screens/choose_icon_screen.dart';
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
import '../view_screens/widgets/ingredient_widget.dart';

@RoutePage()
class AddIngredientsScreen extends StatefulWidget {
  const AddIngredientsScreen({
    super.key,
  });

  static Widget builder(
    BuildContext context,
  ) {
    return AddIngredientsScreen();
  }

  @override
  State<AddIngredientsScreen> createState() => _AddIngredientsScreenState();
}

class _AddIngredientsScreenState extends State<AddIngredientsScreen>
    with TickerProviderStateMixin {
  List<Ingredient> _ingredients = [];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  FocusNode _nameNode = FocusNode();
  FocusNode _descriptionNode = FocusNode();

  String _selectedIcon = '';
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

  Future<void> _initializeData() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
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
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: ValueNotifier(_isFieldsFill()),
        builder: (BuildContext context, bool value, Widget? child) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 80.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomElevatedButton(
                  buttonStyle: CustomButtonStyles.fillRed,
                  text: 'Save',
                  isDisabled: !value,
                  onPressed: _onSaveTap,
                ),
              ],
            ),
          );
        },
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
                    onTap: () => Navigator.of(context).maybePop(),
                    child: CustomImageView(imagePath: Assets.images.btnBack),
                  ),
                  SizedBox(width: 16.h),
                  Expanded(
                    child:
                        Text('Ingredient', style: theme.textTheme.displayLarge),
                  ),
                  SizedBox(width: 16.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCreateNewTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateNewTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Row(
              children: [
                if (_selectedIcon.isNotEmpty) ...[
                  CustomImageView(imagePath: _selectedIcon),
                  SizedBox(
                    width: 20.h,
                  ),
                ],
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: () => _navigateAndSelectIcon(context),
                    text: _selectedIcon.isNotEmpty
                        ? 'Change icon'
                        : 'Select Icon',
                    buttonTextStyle: theme.textTheme.bodyLarge,
                    buttonStyle: CustomButtonStyles.fillPrimaryTL20,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomTextFormField(
              //context,
              controller: _nameController,
              focusNode: _nameNode,
              hintText: 'name',
              onChanged: (vale) {
                setState(() {});
              },
            ),
            SizedBox(
              height: 16.h,
            ),
            CustomTextFormField(
              // context,
              controller: _descriptionController,
              focusNode: _descriptionNode,
              hintText: 'description',
              maxLines: 5,
              onChanged: (vale) {
                setState(() {});
              },
              // hint: 'Description',
            ),
          ],
        ),
      ],
    );
  }

  void _navigateAndSelectIcon(BuildContext context) async {
    final selectedIconPath = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChooseIconScreen()),
    );

    if (selectedIconPath != null) {
      setState(() {
        _selectedIcon = selectedIconPath;
      });
    }
  }

  void _onSaveTap() {
    Ingredient ingredient = Ingredient.empty().copyWith(
      name: _nameController.text,
      note: _descriptionController.text,
      icon: _selectedIcon,
    );

    DatabaseService.saveIngredient(ingredient);
    context.pushRoute(MainRoute());
    setState(() {
      _ingredients = DatabaseService.getAllIngredients();
    });
  }

  bool _isFieldsFill() {
    return (_nameController.value.text.isNotEmpty &&
        _descriptionController.value.text.isNotEmpty &&
        _selectedIcon.isNotEmpty);
  }
}
