import 'package:flutter/material.dart';

import '../../core/app_export.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      routes: [
        HomeRoute(),
        IngredientsRoute(),
        SettingsRoute(),
      ],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButtonBuilder: (_, tabsRouter) {
        return Container(
          //width: 200.h,
          // height: 70.h,
          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
          //decoration: AppDecoration.fillBlack,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildButton(
                tabsRouter: tabsRouter,
                pageIndex: 0,
                text: 'Home',
              ),
              SizedBox(width: 16.h),
              _buildButton(
                tabsRouter: tabsRouter,
                pageIndex: 1,
                text: 'Ingredients',
              ),
              SizedBox(width: 16.h),
              _buildButton(
                tabsRouter: tabsRouter,
                pageIndex: 2,
                text: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildButton({
    String text = '',
    int pageIndex = 0,
    required TabsRouter tabsRouter,
  }) {
    return Expanded(
      child: Container(
        // height: 58.h,
        // width: 58.h,
        decoration: tabsRouter.activeIndex == pageIndex
            ? AppDecoration.primary
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder20)
            : AppDecoration.outlineGray.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder20,
              ),
        padding: EdgeInsets.all(8.h),
        child: InkWell(
          onTap: () => tabsRouter.setActiveIndex(pageIndex),
          child: Padding(
              padding: EdgeInsets.all(4.h),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: tabsRouter.activeIndex == pageIndex
                    ? CustomTextStyles.bodySmallBlack900
                    : theme.textTheme.bodySmall,
              )),
        ),
      ),
    );
  }
}
