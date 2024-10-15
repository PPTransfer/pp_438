import 'package:flutter/material.dart';
import 'package:pp_438/core/app_export.dart';

import '../../../data/models/ingredient_model/ingredient.dart';

class IngredientWidget extends StatelessWidget {
  final Ingredient ingredient;
  final bool showCount;

  const IngredientWidget({super.key, required this.ingredient, this.showCount= true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: AppDecoration.fillGray700.copyWith(color: appTheme.gray900),
        padding: EdgeInsets.all(10.h),
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
                    child: CustomImageView(
                      imagePath: ingredient.icon,
                    ),
                  ),
                  SizedBox(
                    width: 8.h,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Flexible(
                          child: Text(
                            ingredient.name,
                            style: theme.textTheme.displaySmall,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        if(showCount)
                        Text(
                          ingredient.parseAmount(),
                          style: theme.textTheme.bodyLarge,
                        ),
                       // Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              ingredient.note,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
