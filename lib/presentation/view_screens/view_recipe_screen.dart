import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pp_438/core/helpers/enums.dart';
import 'package:pp_438/core/helpers/image_helper.dart';
import 'package:pp_438/core/services/database/database_service.dart';
import 'package:pp_438/data/models/ingredient_model/ingredient.dart';

import '../../core/app_export.dart';
import '../../data/models/recipe_model/recipe.dart';
import '../../data/models/step_model/step_model.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_tab_bar.dart';
import '../../widgets/step_widget.dart';
import 'widgets/ingredient_widget.dart';

@RoutePage()
class ViewRecipeScreen extends StatefulWidget {
  final Recipe recipe;

  const ViewRecipeScreen({super.key, required this.recipe});

  @override
  State<ViewRecipeScreen> createState() => _ViewRecipeScreenState();
}

class _ViewRecipeScreenState extends State<ViewRecipeScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<Ingredient> _recipeIngredients = [];
  List<Ingredient> _allIngredients = [];
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _allIngredients = DatabaseService.getAllIngredients();
    getAllIngredients();
  }

  void getAllIngredients() {
    for (StepModel step in widget.recipe.steps) {
      for (String ingredientId in step.ingredientsIdList) {
        _recipeIngredients
            .add(_allIngredients.firstWhere((x) => x.id == ingredientId));
      }
    }
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
              height: 50.h,
            ),
            _buildHeader(),
            SizedBox(height: 8.h),
            Expanded(child: _buildBody()),
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
              // decoration: AppDecoration.fillGray,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).maybePop(),
                    child: CustomImageView(imagePath: Assets.images.btnBack),
                  ),
                  SizedBox(width: 16.h),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          // horizontal: 50.h,
                          ),
                      // EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 1.0,
                            child: InkWell(
                              // onTap: () => pickImage(),
                              child: Container(
                                // decoration: AppDecoration.fillGray.copyWith(
                                //     borderRadius:
                                //         BorderRadiusStyle.roundedBorder30),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    widget.recipe.photo!.isEmpty
                                        ? CustomImageView(
                                            imagePath: Assets.images.photoEmpty,
                                            radius: BorderRadiusStyle
                                                .roundedBorder30,
                                          )
                                        : Container(
                                            child: ClipRRect(
                                              borderRadius: BorderRadiusStyle
                                                  .roundedBorder30,
                                              // Используйте 20.0 вместо 20.h, если не используете библиотеку для адаптивных размеров
                                              child: FutureBuilder<Uint8List>(
                                                future: Future.value(ImageHelper
                                                    .convertBase64ToFile(
                                                        widget.recipe.photo!)),
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
                                                        fit: BoxFit.cover,
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
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
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
                                                                .circular(500),
                                                        color:
                                                            appTheme.black900),
                                                child: CustomImageView(
                                                  imagePath:
                                                      assetByRecipeCategoryLil(
                                                          widget
                                                              .recipe.category),
                                                ),
                                              ),
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
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (widget.recipe.steps.length != 0)
                                if (widget.recipe.steps[0].hour != 0 ||
                                    widget.recipe.steps[0].minute != 0)
                                  Container(
                                    width: 120.h,
                                    decoration: AppDecoration.secondary,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4.h, vertical: 2.h),
                                    child: Row(
                                      children: [
                                        CustomImageView(
                                          imagePath: Assets.images.timeFill,
                                        ),
                                        SizedBox(
                                          width: 4.h,
                                        ),
                                        Row(
                                          children: [
                                            if (widget.recipe.steps[0].hour !=
                                                0)
                                              Text(
                                                '${widget.recipe.steps[0].hour} hour ',
                                                style: CustomTextStyles
                                                    .bodySmallBlack900,
                                              ),
                                            if (widget.recipe.steps[0].minute !=
                                                0)
                                              Text(
                                                '${widget.recipe.steps[0].minute} min',
                                                style: CustomTextStyles
                                                    .bodySmallBlack900,
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                              RatingBar(
                                initialRating:
                                    widget.recipe.difficult.toDouble(),
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemSize: 20.h,
                                glowColor: appTheme.red300,
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
                                onRatingUpdate: (rating) {},
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'steps ',
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                  Text(
                                    '${widget.recipe.steps.length}',
                                    style: theme.textTheme.displaySmall,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${_recipeIngredients.length}',
                                        style: theme.textTheme.displaySmall,
                                      ),
                                      Text(
                                        ' ingredients',
                                        style: theme.textTheme.bodyLarge,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 16.h),
                  Column(
                    children: [
                      InkWell(
                        onTap: () => _onTapPlay(),
                        child:
                            CustomImageView(imagePath: Assets.images.playBtn),
                      ),
                      SizedBox(height: 8.h),
                      InkWell(
                        onTap: () => _onTapEdit(),
                        child:
                            CustomImageView(imagePath: Assets.images.btnEdit),
                      ),
                      SizedBox(height: 8.h),
                      InkWell(
                        onTap: () => _onTapDelete(),
                        child:
                            CustomImageView(imagePath: Assets.images.btnDelete),
                      ),
                      SizedBox(height: 8.h),
                      InkWell(
                        onTap: () => _onTapNote(),
                        child:
                            CustomImageView(imagePath: Assets.images.btnNote),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${widget.recipe.name}',
            style: theme.textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            '${widget.recipe.description}',
            style: theme.textTheme.bodySmall,
            maxLines: 3,
          ),
          SizedBox(height: 8.h),
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

  Widget _buildStepTabView() {
    return Column(
      children: [
        SizedBox(height: 16.h),
        // CustomElevatedButton(
        //   buttonStyle: CustomButtonStyles.fillPrimaryTL20,
        //   // onPressed: () => _onAddStepTap(),
        //   // height: 35.h,
        //   leftIcon: Icon(
        //     Icons.add,
        //     color: theme.colorScheme.surface,
        //     size: 30.h,
        //   ),
        //   //rightIcon: Padding(padding: padding),
        //   buttonTextStyle: theme.textTheme.displaySmall,
        //   text: 'add a step',
        // ),
        Expanded(
          // height: 500,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.recipe.steps.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: StepWidget(
                  step: widget.recipe.steps[index],
                  index: index + 1,
                ),
              );
            },
          ),
        ),
        // SizedBox(height: 80.h),
      ],
    );
  }

  Widget _buildIngredientsTabView() {
    return Column(
      children: [
        //SizedBox(height: 16.h),
        Expanded(
          child: ListView.builder(
            itemCount: _recipeIngredients.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: IngredientWidget(ingredient: _recipeIngredients[index]),
              );
            },
          ),
        ),
        // SizedBox(height: 80.h),
      ],
    );
  }

  _onTapPlay() {
    if (widget.recipe.steps.isNotEmpty)
      context.pushRoute(CookingRoute(recipe: widget.recipe));
  }

  _onTapEdit() {
    context.pushRoute(ChangeRecipeRoute(recipe: widget.recipe));
  }

  _onTapDelete() {
    DatabaseService.deleteRecipe(widget.recipe.id);
    context.pushRoute(MainRoute());
  }

  _onTapNote() {
    context.pushRoute(NoteRoute(note: widget.recipe.description));
  }
}
