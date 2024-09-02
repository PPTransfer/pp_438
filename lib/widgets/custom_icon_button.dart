import 'package:flutter/material.dart';
import '../core/app_export.dart';
extension IconButtonStyleHelper on CustomIconButton {
  static BoxDecoration get fillRed => BoxDecoration(
        color: appTheme.red300,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(
            20.h,
          ),
        ),
      );
  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.62),
        borderRadius: BorderRadius.circular(20.h),
      );
  static BoxDecoration get fillPrimaryContainerTL20 => BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(
            20.h,
          ),
        ),
      );
  static BoxDecoration get fillPrimaryContainerTL201 => BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20.h),
      );
  static BoxDecoration get outlinePrimary => BoxDecoration(
        color: appTheme.gray90001,
        borderRadius: BorderRadius.circular(10.h),
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 1.h,
        ),
      );
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray90001,
        borderRadius: BorderRadius.circular(10.h),
      );
}
class CustomIconButton extends StatelessWidget {
  CustomIconButton(
      {Key? key,
      this.alignment,
      this.height,
      this.width,
      this.decoration,
      this.padding,
      this.onTap,
      this.child})
      : super(
          key: key,
        );
  final Alignment? alignment;
  final double? height;
  final double? width;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center, child: iconButtonWidget)
        : iconButtonWidget;
  }
  Widget get iconButtonWidget => SizedBox(
        height: height ?? 0,
        width: width ?? 0,
        child: DecoratedBox(
          decoration: decoration ??
              BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(
                    20.h,
                  ),
                ),
              ),
          child: IconButton(
            padding: padding ?? EdgeInsets.zero,
            onPressed: onTap,
            icon: child ?? Container(),
          ),
        ),
      );
}