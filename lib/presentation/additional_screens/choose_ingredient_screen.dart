import 'package:flutter/material.dart';
import 'package:pp_438/core/services/database/database_service.dart';
import 'package:pp_438/data/models/ingredient_model/ingredient.dart';
import 'package:pp_438/presentation/additional_screens/choose_icon_screen.dart';
import 'package:pp_438/widgets/custom_elevated_button.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_tab_bar.dart';
import '../../widgets/custom_text_field_form.dart';
import '../view_screens/widgets/ingredient_widget.dart';

class ChooseIngredientScreen extends StatefulWidget {
  final Function(String)? onTap;

  const ChooseIngredientScreen({super.key, this.onTap});

  @override
  State<ChooseIngredientScreen> createState() => _ChooseIngredientScreenState();
}

class _ChooseIngredientScreenState extends State<ChooseIngredientScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedIcon = '';
  List<Ingredient> _ingredients = [];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  FocusNode _nameNode = FocusNode();
  FocusNode _descriptionNode = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    _tabController = TabController(length: 2, vsync: this);

    _ingredients = await DatabaseService.getAllIngredients();
    setState(() {});
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
            SizedBox(height: 50.h),
            _buildHeader(),
            Expanded(child: _buildContent(context)),
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
            CustomTabBar(
                tabs: ['Choose from', 'Create new'],
                controller: _tabController),
            SizedBox(height: 16.h),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  _buildIngredientsTab(),
                  _buildCreateNewTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientsTab() {
    if (_ingredients.isNotEmpty)
      return Column(
        children: [
          //SizedBox(height: 20.h),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _ingredients.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: InkWell(
                    onTap: () => context.maybePop(_ingredients[index].id),
                    child: IngredientWidget(
                      ingredient: _ingredients[index],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //SizedBox(height: 8.h),
          Text(
            'Tap on create new to\nadd your first ingredient',
            style: CustomTextStyles.displaySmallOnPrimary,
          ),
          CustomImageView(
            imagePath: Assets.images.ingredientEmpty,
          )
        ],
      );
    }
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
        ValueListenableBuilder<bool>(
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
    context.pushRoute(ChangeQuantityRoute(ingredient: ingredient));
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
