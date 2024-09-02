import 'package:flutter/material.dart';

import '../core/app_export.dart';
import '../gen/assets.gen.dart';

class AppDecoration {
  // Background decorations
//   static BoxDecoration get background => BoxDecoration(
//         color: appTheme.gray900,
//         image: DecorationImage(
//           image: AssetImage(Assets.images.backgroundMain.path),
//           fit: BoxFit.fill,
//
//         ),
//       );
//
// // Fill decorations
  static BoxDecoration get fillBlack => BoxDecoration(
        color: appTheme.black900.withOpacity(0.6),
      );

  static BoxDecoration get fillBlack900 => BoxDecoration(
        color: appTheme.black900.withOpacity(0.48),
      );

  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray900.withOpacity(0.75),
      );

  static BoxDecoration get fillGray700 => BoxDecoration(
      color: appTheme.gray700, borderRadius: BorderRadiusStyle.roundedBorder20);
  static BoxDecoration get fillPrimary => BoxDecoration(
    color: theme.colorScheme.primary,
    borderRadius: BorderRadiusStyle.roundedBorder20,
  );

  static BoxDecoration get outlineGray => BoxDecoration(
    color: theme.colorScheme.onPrimary.withOpacity(0.1),
    borderRadius: BorderRadiusStyle.roundedBorder20,
    border: Border.all(color: theme.colorScheme.onPrimary.withOpacity(1)),
  );
  static BoxDecoration get fillPrimaryOpacity => BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.62),
        borderRadius: BorderRadiusStyle.roundedBorder20,
      );

// Primary decorations
  static BoxDecoration get primary => BoxDecoration(
        color: appTheme.red300,
      borderRadius: BorderRadiusStyle.roundedBorder30
      );

// Secondary decorations
  static BoxDecoration get secondary => BoxDecoration(
        color: theme.colorScheme.primaryContainer,
     borderRadius: BorderRadiusStyle.roundedBorder30
      );

// Surface decorations
  static BoxDecoration get surface => BoxDecoration(
        color: theme.colorScheme.primary,
      );
}

class BorderRadiusStyle {
  // Custom borders
  static BorderRadius get customBorderTL20 => BorderRadius.horizontal(
        left: Radius.circular(20.h),
      );

// Rounded borders
  static BorderRadius get roundedBorder10 => BorderRadius.circular(
        10.h,
      );

  static BorderRadius get roundedBorder20 => BorderRadius.circular(
        20.h,
      );

  static BorderRadius get roundedBorder24 => BorderRadius.circular(
        24.h,
      );

  static BorderRadius get roundedBorder30 => BorderRadius.circular(
        30.h,
      );
}
