import 'package:flutter/material.dart';
import '../core/app_export.dart';
extension on TextStyle {
  TextStyle get nunito {
    return copyWith(
      fontFamily: 'Nunito',
    );
  }
  TextStyle get montserrat {
    return copyWith(
      fontFamily: 'Montserrat',
    );
  }
  TextStyle get josefinSans {
    return copyWith(
      fontFamily: 'Josefin Sans',
    );
  }
}
/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.
class CustomTextStyles {
  // Display text style
  static get displayLargeBlack900 => theme.textTheme.displayLarge!.copyWith(
        color: appTheme.black900,
      );
  static get displayLargeBlack900_1 => theme.textTheme.displayLarge!.copyWith(
        color: appTheme.black900,
      );
  static get displayLargeGray90001 => theme.textTheme.displayLarge!.copyWith(
        color: appTheme.gray90001,
      );
  static get displayLargeOnPrimary => theme.textTheme.displayLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  static get displayLargeRed300 => theme.textTheme.displayLarge!.copyWith(
        color: appTheme.red300,
      );
// Headline text style
  static get displayMediumBlack900 => theme.textTheme.displayMedium!.copyWith(
        color: appTheme.black900,
      );
  static get displayMediumOnPrimary => theme.textTheme.displayMedium!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.2),
      );
  static get displayMediumOnPrimary_1 =>
      theme.textTheme.displayMedium!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );
// Label text style
  static get bodySmallBlack900 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black900,
      );
  static get bodySmallGray90001 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray90001,
      );
  static get bodySmallOnPrimary => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.25),
      );
// Title text style
  static get displaySmallBlack900 => theme.textTheme.displaySmall!.copyWith(
        color: appTheme.black900,
      );
  static get displaySmallGray90001 => theme.textTheme.displaySmall!.copyWith(
        color: appTheme.gray90001,
      );
  static get displaySmallOnPrimary => theme.textTheme.displaySmall!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.25),
      );
  static get bodyLargeBlack900 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.black900,
      );
  static get bodyLargeOnPrimary => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.25),
      );
  static get bodyLargeSemiBold => theme.textTheme.bodyLarge!.copyWith(
        fontWeight: FontWeight.w600,
      );
}