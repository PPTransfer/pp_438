import 'dart:async';
import 'dart:typed_data';

import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:pp_438/core/helpers/image_helper.dart';
import 'package:pp_438/data/models/ingredient_model/ingredient.dart';
import 'package:pp_438/data/models/recipe_model/recipe.dart';
import 'package:pp_438/data/models/step_model/step_model.dart';

import '../../core/app_export.dart';
import '../../core/services/database/database_service.dart';
import '../view_screens/widgets/ingredient_widget.dart';

@RoutePage()
class CookingScreen extends StatefulWidget {
  final Recipe recipe;

  const CookingScreen({super.key, required this.recipe});

  @override
  State<CookingScreen> createState() => _CookingScreenState();
}

class _CookingScreenState extends State<CookingScreen>
    with SingleTickerProviderStateMixin {
  late CustomTimerController _controller = CustomTimerController(
      vsync: this,
      begin: Duration(seconds: 1),
      end: Duration(seconds: 12),
      initialState: CustomTimerState.reset,
      interval: CustomTimerInterval.milliseconds);
  PageController pageController = PageController();
  List<Ingredient> _allIngredient = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _allIngredient = DatabaseService.getAllIngredients();

    setState(() {
      _controller.begin = Duration(
        hours: widget.recipe.steps[0].hour,
        minutes: widget.recipe.steps[0].minute,
      );
      _controller.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        
        child: PageView.builder(
          itemCount: widget.recipe.steps.length,
          controller: pageController,
          itemBuilder: (context, index) {
            _controller.begin = Duration(
              hours: widget.recipe.steps[index].hour,
              minutes: widget.recipe.steps[index].minute,
            );
            _controller.reset();
            return Container(
              child: Column(
                children: [
                  SizedBox(height: 50.h),
                  _buildHeader(index),
                  _buildBody(widget.recipe.steps[index]),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 90.h,
              height: 50.h,
              decoration: AppDecoration.secondary,
              child: InkWell(
                onTap: () => _prevStepTap(),
                child: CustomImageView(imagePath: Assets.images.arrowLeftLong),
              ),
            ),
            Container(
              width: 90.h,
              height: 50.h,
              decoration: AppDecoration.primary,
              child: InkWell(
                onTap: () => _nextStepTap(),
                child: CustomImageView(imagePath: Assets.images.arrowRightLong),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(int index) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: AppDecoration.fillGray,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.h),
                    child: Text('${index + 1}',
                        style: theme.textTheme.displayLarge),
                  ),
                  SizedBox(width: 16.h),
                  Expanded(
                    child: Text('${widget.recipe.name}',
                        maxLines: 1,

                        style: CustomTextStyles.displayMediumOnPrimary_1),
                  ),
                  SizedBox(width: 16.h),
                  InkWell(
                    onTap: ()=> context.pushRoute(MainRoute()),
                    child: CustomImageView(imagePath: Assets.images.homeButton),
                  )
                ],
              ),
            ),
          ),
          //_buildCategoryDropdown(),
        ],
      ),
    );
  }

  Widget _buildBody(StepModel step) {
    return Container(
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      if (step.photo.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 50.h,
                          ),
                          // EdgeInsets.all(16.0),
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Container(
                              decoration: AppDecoration.fillGray,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Container(
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder30,
                                      // Используйте 20.0 вместо 20.h, если не используете библиотеку для адаптивных размеров
                                      child: FutureBuilder<Uint8List>(
                                        future: Future.value(
                                            ImageHelper.convertBase64ToFile(
                                                step.photo)),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                                  ConnectionState.done &&
                                              snapshot.hasData) {
                                            return ClipRRect(
                                              borderRadius: BorderRadiusStyle
                                                  .roundedBorder30,
                                              child: Image.memory(
                                                snapshot.data!,
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          } else {
                                            return Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  // Container(
                                  //   child: InkWell(
                                  //     borderRadius: BorderRadius.circular(500),
                                  //     child: Padding(
                                  //       padding: const EdgeInsets.all(8.0),
                                  //       child: Column(
                                  //         crossAxisAlignment:
                                  //             CrossAxisAlignment.end,
                                  //         children: [
                                  //           Container(
                                  //               height: 50,
                                  //               width: 50,
                                  //               decoration: AppDecoration.primary
                                  //                   .copyWith(
                                  //                       borderRadius:
                                  //                           BorderRadius.circular(
                                  //                               500),
                                  //                       color: appTheme.black900),
                                  //               child: CustomImageView(
                                  //                 imagePath: Assets.images.trash,
                                  //               )),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.h),
                        child: Text(
                          step.name,
                          style: theme.textTheme.displaySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => context.pushRoute(
                    NoteRoute(note: step.description),
                  ),
                  child: CustomImageView(imagePath: Assets.images.btnNote),
                ),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  child: Text(
                    step.description,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                ValueListenableBuilder<CustomTimerState>(
                    valueListenable: _controller.state,
                    builder: (context, value, child) {
                      return Container(
                        decoration: value == CustomTimerState.counting
                            ? AppDecoration.primary.copyWith(
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(20.h),
                                ),
                              )
                            : AppDecoration.fillGray.copyWith(
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(20.h),
                                ),
                              ),
                        margin: EdgeInsets.only(
                          left: 16.h,
                        ),
                        padding: EdgeInsets.only(
                          left: 16.h,
                        ),
                        child: Row(
                          children: [
                            CustomImageView(
                              imagePath: Assets.images.clock,
                              color: (value == CustomTimerState.reset ||
                                      value == CustomTimerState.paused)
                                  ? theme.colorScheme.surface
                                  : appTheme.black900,
                            ),
                            SizedBox(
                              width: 16.h,
                            ),
                            Expanded(
                              child: CustomTimer(
                                controller: _controller,
                                builder: (state, remaining) {
                                  // Build the widget you want!
                                  return Column(
                                    children: [
                                      Text(
                                        "${remaining.hours}:${remaining.minutes}:${remaining.seconds}",
                                        style:
                                            (value == CustomTimerState.reset ||
                                                    value ==
                                                        CustomTimerState.paused)
                                                ? theme.textTheme.displayLarge
                                                : CustomTextStyles
                                                    .displayLargeBlack900_1,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            if (value == CustomTimerState.reset ||
                                value == CustomTimerState.paused)
                              InkWell(
                                child: CustomImageView(
                                  imagePath: Assets.images.startTimer,
                                  fit: BoxFit.fitWidth,
                                ),
                                onTap: () => _controller.start(),
                              ),
                            if (value == CustomTimerState.counting)
                              InkWell(
                                child: CustomImageView(
                                  imagePath: Assets.images.stopTimer,
                                  fit: BoxFit.fitWidth,
                                ),
                                onTap: () => _controller.pause(),
                              ),
                            if (value == CustomTimerState.finished)
                              InkWell(
                                child: CustomImageView(
                                  imagePath: Assets.images.restartTimer,
                                  fit: BoxFit.fitWidth,
                                ),
                                onTap: () => _controller.start(),
                              ),
                          ],
                        ),
                      );
                    }),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Text(
                'ingredients',
                style: theme.textTheme.displaySmall,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: step.ingredientsIdList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: InkWell(
                        onTap: () => context.maybePop(_allIngredient.firstWhere(
                            (x) => x.id == step.ingredientsIdList[index])),
                        child: IngredientWidget(
                          ingredient: _allIngredient.firstWhere(
                              (x) => x.id == step.ingredientsIdList[index]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
          ],
        ),
      ),
    );
  }

  _prevStepTap() {
    _controller.pause();
    _controller.reset();
    pageController.previousPage(
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  _nextStepTap() {
    _controller.pause();
    _controller.reset();
    pageController.nextPage(
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
