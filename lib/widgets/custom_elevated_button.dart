import 'package:flutter/material.dart';
import '../core/app_export.dart';
import 'base_button.dart';
class CustomElevatedButton extends BaseButton {
  CustomElevatedButton(
      {Key? key,
      this.decoration,
      this.leftIcon,
      this.rightIcon,
      EdgeInsets? margin,
      VoidCallback? onPressed,
      ButtonStyle? buttonStyle,
      Alignment? alignment,
      TextStyle? buttonTextStyle,
      bool? isDisabled,
      double? height,
      double? width,
      required String text})
      : super(
          text: text,
          onPressed: onPressed,
          buttonStyle: buttonStyle,
          isDisabled: isDisabled,
          buttonTextStyle: buttonTextStyle,
          height: height,
          width: width,
          alignment: alignment,
          margin: margin,
        );
  final BoxDecoration? decoration;
  final Widget? leftIcon;
  final Widget? rightIcon;
  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildElevatedButtonWidget)
        : buildElevatedButtonWidget;
  }
  Widget get buildElevatedButtonWidget => Container(
        height: this.height ?? 42.h,
        width: this.width ?? double.maxFinite,
        margin: margin,
        decoration: decoration,
        child: ElevatedButton(
          style: buttonStyle,
          onPressed: isDisabled ?? false ? null : onPressed ?? () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:  10.0),
                child: SizedBox(width: 30.h, child: leftIcon ?? const SizedBox.shrink()),
              ),
              Expanded(
                child: Text(
                  text,
                  style: buttonTextStyle ?? theme.textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right:  10.0),
                child: SizedBox(width: 30.h, child: rightIcon ?? const SizedBox.shrink()),
              )
            ],
          ),
        ),
      );
}