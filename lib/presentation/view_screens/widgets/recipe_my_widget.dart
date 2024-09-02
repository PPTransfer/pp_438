import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pp_438/core/app_export.dart';
import 'package:pp_438/core/helpers/image_helper.dart';
import 'package:pp_438/core/helpers/string_helper.dart';
import 'package:pp_438/gen/assets.gen.dart';
import 'package:pp_438/theme/app_decoration.dart';

import '../../../data/models/recipe_model/recipe.dart';

class RecipeMyWidget extends StatelessWidget {
  final Recipe recipe;
  const RecipeMyWidget({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return InkWell(

      child: Container(
        decoration: AppDecoration.primary,
        padding: EdgeInsets.all(8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: AppDecoration.primary
                        .copyWith(color: theme.colorScheme.onPrimaryContainer),
                    child: recipe.photo == null? CustomImageView(
                      imagePath: Assets.images.addPic,
                    ):ClipRRect(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder30,
                                  // Используйте 20.0 вместо 20.h, если не используете библиотеку для адаптивных размеров
                                  child: FutureBuilder<Uint8List>(
                                    future: Future.value(ImageHelper.convertBase64ToFile(recipe.photo!) ),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                              ConnectionState.done &&
                                          snapshot.hasData) {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadiusStyle.roundedBorder30,
                                          child: Image.memory(
                                            snapshot.data!,
                                            fit: BoxFit.fill,
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
                  SizedBox(
                    width: 8.h,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Text(
                            recipe.name,
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                      
                        Spacer(),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(8.h),
                    decoration: AppDecoration.primary.copyWith(
                      color: appTheme.gray900,
                    ),
                    child: Text(
                      capitalize(recipe.category.name),
                      style: theme.textTheme.bodyMedium,
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
                    recipe.description,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                if(recipe.isFavorite)
                CustomImageView(
                  imagePath: Assets.images.favoriteFill,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
