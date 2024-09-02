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
import 'package:pp_438/data/models/recipe_model/recipe.dart';
import 'package:pp_438/widgets/background_widget.dart';
import 'package:pp_438/widgets/custom_text_field_form.dart';

import '../../core/helpers/enums.dart';
import '../../gen/assets.gen.dart';
import '../../widgets/custom_elevated_button.dart';

@RoutePage()
class AddRecipeScreen extends StatefulWidget {
  final Recipe recipe;

  const AddRecipeScreen({
    super.key,
    required this.recipe,
  });

  static Widget builder(BuildContext context,
      Recipe recipe,) {
    return AddRecipeScreen(
      recipe: recipe,
    );
  }

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen>
    with TickerProviderStateMixin {
  Uint8List _selectedPhoto = Uint8List(0);
  RecipeCategory? _selectedCategory;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  FocusNode _nameNode = FocusNode();
  FocusNode _descriptionNode = FocusNode();
  FocusNode _hourNode = FocusNode();
  FocusNode _minuteNode = FocusNode();

  int _numberOfPortions = 1;

  bool isEdit = false;
  double _rating = 0;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    if (widget.recipe.id.isNotEmpty) {
      isEdit = true;
      _nameController.text = widget.recipe.name;
      _descriptionController.text = widget.recipe.description;
      _selectedCategory = widget.recipe.category;
      _selectedPhoto = ImageHelper.convertBase64ToFile(widget.recipe.photo!);
      setState(() {
        _numberOfPortions = widget.recipe.difficult;
      });
    }
  }

  void updateRating(double value) {
    setState(() {
      _rating = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery
        .of(context)
        .viewInsets
        .bottom != 0;
    return Scaffold(
      extendBodyBehindAppBar: true,
    resizeToAvoidBottomInset: false,
      extendBody: true,
      //  appBar: CustomAppBar(
      //   leadingWidth: 60.h,
      //   leading: CustomIconButton(
      //     onTap: () => NavigatorService.goBack(),
      //    //
      //     child: CustomImageView(
      //       imagePath: Assets.images.btnBack,
      //     ),
      //   ),
      // ),
      body: BackgroundWidget(

        child: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            Container(
              decoration: AppDecoration.fillGray,
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   InkWell(
                    onTap: () => context.replaceRoute(MainRoute()),
                    child: CustomImageView(imagePath: Assets.images.btnBack),
                  ),
                  SizedBox(
                    width: 16.h,
                  ),
                  Expanded(
                      child:
                      Text('Recipe', style: theme.textTheme.displayLarge)),
                  SizedBox(
                    width: 16.h,
                  ),
                  InkWell(
                    //decoration: AppDecoration.fillPrimary,
                    onTap: () {
                      pickImage();
                    },
                    child: CustomImageView(imagePath: Assets.images.addPic),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      if (_selectedPhoto.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 50.h,
                          ),
                          // EdgeInsets.all(16.0),
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: InkWell(
                              onTap: () => pickImage(),
                              child: Container(
                                decoration: AppDecoration.fillGray,
                                child: _selectedPhoto.isEmpty
                                    ? Padding(
                                  padding: EdgeInsets.all(110.h),
                                  child: CustomImageView(
                                    imagePath: Assets.images.addPic,
                                  ),
                                )
                                    : Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadiusStyle
                                            .roundedBorder30,
                                        // Используйте 20.0 вместо 20.h, если не используете библиотеку для адаптивных размеров
                                        child: FutureBuilder<Uint8List>(
                                          future: Future.value(
                                              _selectedPhoto),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState
                                                    .done &&
                                                snapshot.hasData) {
                                              return ClipRRect(
                                                borderRadius:
                                                BorderRadiusStyle
                                                    .roundedBorder30,
                                                child: Image.memory(
                                                  snapshot.data!,
                                                  fit: BoxFit.fill,
                                                ),
                                              );
                                            } else {
                                              return Center(
                                                child:
                                                CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: InkWell(
                                        borderRadius:
                                        BorderRadius.circular(500),
                                        onTap: () {
                                          setState(() {
                                            _selectedPhoto = Uint8List(0);
                                          });
                                        },
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: AppDecoration
                                                      .primary
                                                      .copyWith(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          500),
                                                      color: appTheme
                                                          .black900),
                                                  child: CustomImageView(
                                                    imagePath: Assets
                                                        .images.trash,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                             flex: 3,
                              child: _buildCategoryDropdown(),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Flexible(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Difficulty',
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                  RatingBar(
                                    initialRating: 0,
                                    direction: Axis.horizontal,
                                    itemCount: 5,
                                    itemSize: 20.h,
                                    ratingWidget: RatingWidget(
                                      full: CustomImageView(
                                          imagePath: Assets.images.starFull),
                                      half: CustomImageView(
                                          imagePath: Assets.images.starFull),
                                      empty: CustomImageView(
                                          imagePath: Assets.images.starEmpty),
                                    ),
                                    itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                    onRatingUpdate: (rating) {
                                      _rating = rating;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
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
                        height: 120.h,
                      ),
                    ],
                  ),
                ),
              ),
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
                    text: !isEdit ? 'Create' : 'Save',
                    buttonStyle: CustomButtonStyles.fillRed,
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

  Widget _buildCategoryDropdown() {
    return Container(
      // decoration: AppDecoration.fillPrimary,
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.h),
      child: DropdownButtonHideUnderline(

        child: DropdownButton2<RecipeCategory>(
          // customButton: CustomImageView(
          //   height: 60.h,
          //   width: 60.h,
          //   imagePath: assetByRecipeCategory(_selectedCategory!),
          // ),

          menuItemStyleData:  MenuItemStyleData(
            height: 100.h,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
          iconStyleData: IconStyleData(iconSize: 0),
          buttonStyleData: ButtonStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),

              color: theme.colorScheme.primary,
            ),
           // elevation: 2,
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

          hint: Container(
            decoration: AppDecoration.fillPrimaryOpacity
                .copyWith(color: theme.colorScheme.primary),
            padding: EdgeInsets.symmetric(
              horizontal: 8.h,
              vertical: 8.h,
            ),
            child: Text(
              'Select meal',
              style: theme.textTheme.displaySmall,
            ),
          ),
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
                      capitalize(category
                          .toString()
                          .split('.')
                          .last),
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

  bool _isFieldsFill() {
    return (_nameController.value.text.isNotEmpty &&
        _descriptionController.value.text.isNotEmpty &&
        _selectedCategory != null);
  }

  void _changeNumberOfPortions(int iteration) {
    if (_numberOfPortions + iteration > 0 && _numberOfPortions + iteration < 11)
      setState(() {
        _numberOfPortions += iteration;
      });
  }

  void _onSaveTap() async {
    if (_isFieldsFill()) {
      Recipe recipe = Recipe(
        id: widget.recipe.id,
        name: _nameController.value.text,
        category: _selectedCategory!,
        difficult: _rating.toInt(),
        description: _descriptionController.value.text,
        ingredients: widget.recipe.ingredients,
        steps: widget.recipe.steps,
        photo:
             ImageHelper.convertFileToBase64(_selectedPhoto)

      );
      // if (!isEdit) {
      //   await DatabaseService.saveRecipe(recipe);
      //   context.pushRoute(ViewRecipeRoute(recipe: recipe));
      // } else {
        await DatabaseService.saveRecipe(recipe);
        context.pushRoute(MainRoute());
      // }
      //context.pushRoute(MainRoute())  ;
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
}
