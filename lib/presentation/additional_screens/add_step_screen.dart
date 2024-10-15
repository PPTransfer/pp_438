import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pp_438/core/app_export.dart';
import 'package:pp_438/core/helpers/image_helper.dart';
import 'package:pp_438/data/models/ingredient_model/ingredient.dart';
import 'package:pp_438/data/models/recipe_model/recipe.dart';
import 'package:pp_438/data/models/step_model/step_model.dart';
import 'package:pp_438/presentation/view_screens/widgets/ingredient_widget.dart';
import 'package:pp_438/widgets/custom_text_field_form.dart';

import '../../core/services/database/database_service.dart';
import '../../widgets/custom_elevated_button.dart';
import 'choose_ingredient_screen.dart';

@RoutePage()
class AddStepScreen extends StatefulWidget {
  final Recipe recipe;
  final StepModel? step;
  final int? index;

  const AddStepScreen({
    super.key,
    required this.recipe,
    this.step,
    this.index,
  });

  @override
  State<AddStepScreen> createState() => _AddStepScreenState();
}

class _AddStepScreenState extends State<AddStepScreen>
    with TickerProviderStateMixin {
  List<StepModel> _steps = [];
  List<Ingredient> _ingredients = [];
  StepModel _newStep = StepModel.empty();
  Uint8List _selectedPhoto = Uint8List(0);
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

  bool _isEdit = false;

  TimeOfDay _selectedTime = TimeOfDay(hour: 0, minute: 0);

  @override
  void initState() {
    super.initState();

    _initializeData();
  }

  Future<void> _initializeData() async {
    _ingredients = await DatabaseService.getAllIngredients();
    if (widget.step != null) {
      _isEdit = true;
      _newStep = widget.step!;
      _nameController.text = widget.step!.name;
      _descriptionController.text = widget.step!.description;
      _selectedTime =
          TimeOfDay(hour: widget.step!.hour, minute: widget.step!.minute);
      setState(() {
        _steps = widget.recipe.steps;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: BackgroundWidget(
        child: Column(
          children: [
            SizedBox(height: 50.h),
            _buildHeader(),
            Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomTextFormField(
                          //context,
                          controller: _nameController,
                          focusNode: _nameNode,
                          hintText: 'name',
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
                          // hint: 'Description',
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomElevatedButton(
                          leftIcon: CustomImageView(
                            imagePath: Assets.images.timeFill,
                            height: 30.h,
                            color: theme.colorScheme.surface,
                          ),
                          text: (_selectedTime.hour == 0 &&
                                  _selectedTime.minute == 0)
                              ? 'add time'
                              : (_selectedTime.hour == 0
                                      ? ''
                                      : '${_selectedTime.hour} hour ') +
                                  (_selectedTime.minute == 0
                                      ? ''
                                      : ' ${_selectedTime.minute} min'),
                          buttonTextStyle: theme.textTheme.displaySmall,
                          onPressed: () {
                            _pickTime();
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomElevatedButton(
                          leftIcon: CustomImageView(
                            imagePath: Assets.images.addRound,
                            height: 30.h,
                            color: theme.colorScheme.surface,
                          ),
                          text: 'add ingredients',
                          buttonStyle: CustomButtonStyles.fillPrimaryTL20,
                          buttonTextStyle: theme.textTheme.displaySmall,
                          onPressed: () {
                            _onAddIngredientsTap(context);
                          },
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _newStep.ingredientsIdList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: InkWell(
                                onTap: () => _onAddIngredientQuantityTap(
                                    context,
                                    _ingredients.firstWhere((x) =>
                                        x.id ==
                                        _newStep.ingredientsIdList[index])),
                                child: IngredientWidget(
                                    ingredient: _ingredients.firstWhere((x) =>
                                        x.id ==
                                        _newStep.ingredientsIdList[index])),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 120.h),
                      ],
                    ),
                  ),
                ),
                if (_isEdit)
                  Positioned(
                      right: 0,
                      child: InkWell(
                        onTap: () => _onDeleteStepTap(widget.index! - 1),
                        child: CustomImageView(
                          imagePath: Assets.images.btnDelete,
                        ),
                      ))
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen,
        child: ValueListenableBuilder<bool>(
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
                    text: 'Create',
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
                    child: CustomImageView(
                      imagePath: Assets.images.btnBack,
                    ),
                  ),
                  SizedBox(width: 16.h),
                  Expanded(
                    child: Text(
                      _isEdit
                          ? '${widget.index} Step'
                          : '${widget.recipe.steps.length + 1} Step',
                      style: theme.textTheme.displayLarge,
                    ),
                  ),
                  SizedBox(width: 16.h),
                  Container(
                    child: InkWell(
                      onTap: () => _pickImage(),
                      child: CustomImageView(
                        imagePath: Assets.images.addPic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // _buildCategoryDropdown(),
        ],
      ),
    );
  }

  void _onDeleteStepTap(int index) {
    setState(() {
      _steps.removeAt(index);
      DatabaseService.saveRecipe(widget.recipe);
    });

    context.maybePop(index - 1);
    context.replaceRoute(ChangeRecipeRoute(recipe: widget.recipe));
  }

  bool _isFieldsFill() {
    return (_nameController.value.text.isNotEmpty &&
        _descriptionController.value.text.isNotEmpty);
  }

  void _onSaveTap() async {
    if (_isFieldsFill()) {
      _newStep = StepModel.empty().copyWith(
          id: (_isEdit ? widget.step!.id : widget.recipe.steps.length + 1)
              .toString(),
          name: _nameController.value.text,
          description: _descriptionController.value.text,
          hour: _selectedTime.hour,
          minute: _selectedTime.minute,
          ingredientsIdList: _newStep.ingredientsIdList,
          photo: ImageHelper.convertFileToBase64(_selectedPhoto));

      //_steps.add(_newStep);
      // Recipe recipe = Recipe(
      //   id: widget.recipe.id,
      //   name: widget.recipe.name,
      //   category: widget.recipe.category,
      //   difficult: widget.recipe.difficult,
      //   description: widget.recipe.description,
      //   ingredients: widget.recipe.ingredients,
      //   steps: _steps,
      //   photo: widget.recipe.photo,
      // );
      //
      // await DatabaseService.saveRecipe(recipe);
      context.maybePop(_newStep);
    }
  }

  Future _pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => _selectedPhoto = imageTemp.readAsBytesSync());
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: appTheme.red300,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  void _onAddIngredientsTap(BuildContext context) async {
    final ingredientId = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChooseIngredientScreen()),
    );

    if (ingredientId != null) {
      // Use the selectedIconPath
      setState(() {
        _newStep.ingredientsIdList.add(ingredientId);
        _ingredients = DatabaseService.getAllIngredients();
      });
    }
  }

  void _onAddIngredientQuantityTap(
      BuildContext context, Ingredient ingredient) async {
    final ingredientId =
        await context.pushRoute(ChangeQuantityRoute(ingredient: ingredient));

    if (ingredientId != null) {
      // Use the selectedIconPath
      setState(() {
        //_newStep.ingredientsIdList.add(ingredientId);
        _ingredients = DatabaseService.getAllIngredients();
      });
    }
  }
}
