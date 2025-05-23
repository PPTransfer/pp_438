// import 'package:custom_rating_bar/custom_rating_bar.dart';
// import 'package:flutter/material.dart';
// import '../core/app_export.dart';
// // ignore_for_file: must_be_immutable
// class CustomRatingBar extends StatelessWidget {
//   CustomRatingBar(
//       {Key? key,
//       this.alignment,
//       this.ignoreGestures,
//       this.initialRating,
//       this.itemSize,
//       this.itemCount,
//       this.color,
//       this.unselectedColor,
//       this.onRatingUpdate})
//       : super(
//           key: key,
//         );
//   final Alignment? alignment;
//   final bool? ignoreGestures;
//   final double? initialRating;
//   final double? itemSize;
//   final int? itemCount;
//   final Color? color;
//   final Color? unselectedColor;
//   Function(double)? onRatingUpdate;
//   @override
//   Widget build(BuildContext context) {
//     return alignment != null
//         ? Align(
//             alignment: alignment ?? Alignment.center, child: ratingBarWidget)
//         : ratingBarWidget;
//   }
//   Widget get ratingBarWidget => RatingBar.builder(
//         ignoreGestures: ignoreGestures ?? false,
//         initialRating: initialRating ?? 0,
//         minRating: 0,
//         direction: Axis.horizontal,
//         allowHalfRating: false,
//         itemSize: itemSize ?? 20.h,
//         unratedColor: unselectedColor,
//         itemCount: itemCount ?? 5,
//         updateOnDrag: true,
//         itemBuilder: (context, _) {
//           return Icon(
//             Icons.star,
//             color: color ?? appTheme.red300,
//           );
//         },
//         onRatingUpdate: (rating) {
//           onRatingUpdate!.call(rating);
//         },
//       );
// }