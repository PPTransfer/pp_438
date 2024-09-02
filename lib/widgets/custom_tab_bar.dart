

import 'package:flutter/material.dart';

import '../core/app_export.dart';

class CustomTabBar extends StatefulWidget {
  final List<String> tabs;
  final TabController controller;
   final Function(int)? onTap;

  CustomTabBar({required this.tabs, required this.controller,  this.onTap});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(4),
      decoration: AppDecoration.fillPrimary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: List.generate(widget.tabs.length, (index) {
          return Expanded(
            child: GestureDetector(
              onTap: () {

                  widget.controller.animateTo(index);

                widget.onTap?.call(index);
              },
              child: AnimatedBuilder(
                animation: widget.controller.animation!,
                builder: (context, child) {
                  final isSelected = widget.controller.index == index;
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 0),
                    margin: EdgeInsets.all(4),
                    //margin: EdgeInsets.symmetric( horizontal: 8),
                    decoration: isSelected
                        ? AppDecoration.primary.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder30,
                          )
                        : AppDecoration.fillPrimary.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder30,
                          ),
                    //color: isSelected? appTheme.gray900: Colors.white,
                    child: Text(widget.tabs[index],
                        textAlign: TextAlign.center,
                        style: isSelected
                            ? CustomTextStyles.displaySmallBlack900
                            : theme.textTheme.displaySmall),
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
