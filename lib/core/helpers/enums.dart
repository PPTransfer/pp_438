import 'dart:ui';

import 'package:hive/hive.dart';

import '../../gen/assets.gen.dart';
part 'enums.g.dart';

enum AgreementType {
  privacy,
  terms,
}

@HiveType(typeId: 2)
enum RecipeCategory {
  @HiveField(0)
  breakfast,
  @HiveField(1)
  dinner,
  @HiveField(2)
  lunch,
  @HiveField(3)
  dessert,
  @HiveField(4)
  grill,
  @HiveField(5)
  snack
}

@HiveType(typeId: 3)
enum Unit {
  @HiveField(0)
  kgg,
  @HiveField(1)
  pcs,
  @HiveField(2)
  lboz,

}

const Map<int, String> categoriesList = {
  0: 'Vegetables',
  1: 'Fruit and berries',
  2: 'Herbs and spicy herbs',
  3: 'Dairy and eggs',
  4: 'Dairy alternatives',
  5: 'Seafood',
  6: 'Cereals and pulses',
  7: 'Flour and baking',
  8: 'Fats and oils',
  9: 'Spices and seasonings',
  10: 'Sauces and marinades',
  11: 'Nuts and seeds',
  12: 'Canned and frozen foods',
  13: 'Meat substitute',
};

String assetByRecipeCategory(RecipeCategory category) {
  switch (category) {
    case RecipeCategory.breakfast:
      return Assets.images.iconBreak;
    case RecipeCategory.dinner:
      return Assets.images.iconDinner;
    case RecipeCategory.lunch:
      return Assets.images.iconLunch;
    case RecipeCategory.dessert:
      return Assets.images.iconDessert;
    case RecipeCategory.grill:
      return Assets.images.iconGrill;
    case RecipeCategory.snack:
      return Assets.images.iconSnack;
  }
}

String assetByRecipeCategoryLil(RecipeCategory category) {
  switch (category) {
    case RecipeCategory.breakfast:
      return Assets.images.iconBreakLil;
    case RecipeCategory.dinner:
      return Assets.images.iconDinnerLil;
    case RecipeCategory.lunch:
      return Assets.images.iconLunchLil;
    case RecipeCategory.dessert:
      return Assets.images.iconDessertLil;
    case RecipeCategory.grill:
      return Assets.images.iconGrillLil;
    case RecipeCategory.snack:
      return Assets.images.iconSnackLil;
  }
}

String unitToString(Unit unit) {
  switch (unit) {
    case Unit.kgg:
      return 'Kg/g';
    case Unit.pcs:
      return 'Pieces';
    case Unit.lboz:
      return 'Lb/oz';
    default:
      return '';
  }
}
// String imageByCategory(int index) {
//   switch (index) {
//     case 0:
//       return Assets.images.a1;
//     case 1:
//       return Assets.images.a2;
//     case 2:
//       return Assets.images.a3;
//     case 3:
//       return Assets.images.a4;
//     case 4:
//       return Assets.images.a5;
//     case 5:
//       return Assets.images.a6;
//     case 6:
//       return Assets.images.a7;
//     case 7:
//       return Assets.images.a8;
//     case 8:
//       return Assets.images.a9;
//     case 9:
//       return Assets.images.a10;
//     case 10:
//       return Assets.images.a11;
//     case 11:
//       return Assets.images.a12;
//     case 12:
//       return Assets.images.a13;
//     case 13:
//       return Assets.images.a14;
//     default:
//       return Assets.images.a1;
//   }
// }

Color colorByCategory(int index) {
  switch (index) {
    case 0:
      return Color(0xFFB1D16A);
    case 1:
      return Color(0xFFFFB381);
    case 2:
      return Color(0xFF297C3B);
    case 3:
      return Color(0xFFFFFBD1);
    case 4:
      return Color(0xFFFFF4D5);
    case 5:
      return Color(0xFFD9E2FC);
    case 6:
      return Color(0xFFD1B9B0);
    case 7:
      return Color(0xFFF2E8E4);
    case 8:
      return Color(0xFFF9E68C);
    case 9:
      return Color(0xFFE54D2E);
    case 10:
      return Color(0xFFEA9280);
    case 11:
      return Color(0xFFEEEADD);
    case 12:
      return Color(0xFFD7CFF9);
    case 13:
      return Color(0xFFFDD8D8);
    default:
      return Color(0xFFFFB381);
  }
}
