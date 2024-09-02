import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color? backgroundColor;
  final bool isActive;
  final Size? size;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.isActive = true,
    this.size,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Container(
        alignment: Alignment.center,
        height: size?.height ?? 52,
        width: size?.width ?? double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor ??
              Theme.of(context)
                  .colorScheme
                  .primary
                  .withOpacity(isActive ? 1 : 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onPrimary
                    .withOpacity(isActive ? 1 : 0.5),
              ),
        ),
      ),
      onPressed: isActive ? onPressed : null,
    );
  }
}

class AppButtonWithWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color? backgroundColor;
  final bool isActive;
  final Size? size;

  const AppButtonWithWidget({
    super.key,
    required this.onPressed,
    required this.child,
    this.isActive = true,
    this.size,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Container(
        alignment: Alignment.center,
        height: size?.height ?? 52,
        width: size?.width ?? double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor ??
              Theme.of(context)
                  .colorScheme
                  .primary
                  .withOpacity(isActive ? 1 : 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: child,
      ),
      onPressed: isActive ? onPressed : null,
    );
  }
}
