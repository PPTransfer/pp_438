import 'package:flutter/material.dart';

import '../core/app_export.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;

  const BackgroundWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomImageView(
          imagePath: Assets.images.backgroundMain.path,
          fit: BoxFit.fill,
        ),
        child,
      ],
    );
  }
}
