import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pp_438/core/app_export.dart';
import 'package:pp_438/core/helpers/image_helper.dart';
import 'package:pp_438/data/models/recipe_model/recipe.dart';
import 'package:pp_438/theme/app_decoration.dart';

import '../../../gen/assets.gen.dart';

class RecipeWidget extends StatelessWidget {
  final Recipe recipe;
  const RecipeWidget({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 300.h,
      width: 80.h,
      padding: EdgeInsets.all(8.h),
      decoration: AppDecoration.primary,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
                decoration: AppDecoration.primary,
                child: recipe.photo != null
                    ? ClipRRect(
                        borderRadius: BorderRadiusStyle.roundedBorder30,
                        // Используйте 20.0 вместо 20.h, если не используете библиотеку для адаптивных размеров
                        child: FutureBuilder<Uint8List>(
                          future: Future.value(
                              ImageHelper.convertBase64ToFile(recipe.photo!)),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData) {
                              return ClipRRect(
                                borderRadius: BorderRadiusStyle.roundedBorder30,
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
                      )
                    : Container(
                        decoration: AppDecoration.primary.copyWith(
                            color: theme.colorScheme.onPrimaryContainer,
                            border: Border.all(width: 0)),
                        //color: theme.colorScheme.onPrimaryContainer,
                        child: CustomImageView(
                          imagePath: Assets.images.addPic,
                        ),
                      )),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(recipe.name, style: theme.textTheme.bodySmall, overflow: TextOverflow.ellipsis, maxLines: 2,),
        ],
      ),
    );
  }
}
