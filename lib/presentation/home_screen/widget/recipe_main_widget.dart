import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pp_438/core/app_export.dart';
import 'package:pp_438/core/helpers/enums.dart';
import 'package:pp_438/core/helpers/image_helper.dart';
import 'package:pp_438/data/models/recipe_model/recipe.dart';

class RecipeMainWidget extends StatefulWidget {
  final Recipe recipe;
  final Function() onTap;


  const RecipeMainWidget(
      {super.key, required this.recipe, required this.onTap});

  @override
  State<RecipeMainWidget> createState() => _RecipeMainWidgetState();
}

class _RecipeMainWidgetState extends State<RecipeMainWidget> {
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushRoute(
        ViewRecipeRoute(recipe: widget.recipe),
      ),
      child: Container(
        height: 150.h,
        decoration: AppDecoration.fillBlack900.copyWith(
          color: appTheme.gray900,
          borderRadius: BorderRadiusStyle.roundedBorder20,
          image: widget.recipe.photo!.isNotEmpty
              ? DecorationImage(
                  image: MemoryImage(
                      ImageHelper.convertBase64ToFile(widget.recipe.photo!)),
                  fit: BoxFit.cover)
              : null,
        ),
        padding: EdgeInsets.all(10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              //height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      widget.recipe.name,
                      style: theme.textTheme.displaySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 8.h,
                  ),
                  Container(
                      height: 30.h,
                      width: 30.h,
                      //padding: EdgeInsets.all(5.h),

                      child: CustomImageView(
                        imagePath:
                            assetByRecipeCategoryLil(widget.recipe.category),
                      )),
                ],
              ),
            ),
            Container(
              // height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
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
                            if (widget.recipe.steps.isNotEmpty)
                              Row(
                                children: [
                                  if (widget.recipe.steps[0].hour != 0)
                                    Text(
                                      '${widget.recipe.steps[0].hour} hour ',
                                      style: CustomTextStyles.bodySmallBlack900,
                                    ),
                                  if (widget.recipe.steps[0].minute != 0)
                                    Text(
                                      '${widget.recipe.steps[0].minute} min',
                                      style: CustomTextStyles.bodySmallBlack900,
                                    ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 16.h,
                      ),
                      RatingBar(
                        initialRating: widget.recipe.difficult.toDouble(),
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemSize: 20.h,
                        ignoreGestures: true,
                        ratingWidget: RatingWidget(
                          full: CustomImageView(
                              imagePath: Assets.images.starFull),
                          half: CustomImageView(
                              imagePath: Assets.images.starFull),
                          empty: CustomImageView(
                              imagePath: Assets.images.starEmpty),
                        ),
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        onRatingUpdate: (rating) {},
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      widget.recipe.isFavorite = !widget.recipe.isFavorite;
                      widget.onTap?.call();
                    },
                    child: CustomImageView(
                      height: 25.h,
                      imagePath: widget.recipe.isFavorite
                          ? Assets.images.favoriteFill
                          : Assets.images.favoriteEmpty,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    widget.recipe.description,
                    style: theme.textTheme.bodySmall,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
