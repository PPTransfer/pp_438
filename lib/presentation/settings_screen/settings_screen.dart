import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:pp_438/presentation/settings_screen/agreement_screen/agreement_screen.dart';
import 'package:pp_438/widgets/support_pop_up.dart';

import '../../core/app_export.dart';
import '../../core/helpers/dialog_helper.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  static Widget builder(BuildContext context) {
    return SettingsScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,

      // appBar: CustomAppBar(
      //   leadingWidth: 60.h,
      //   height: 50.h,
      //   leading: Container(
      //     height: 50.h,
      //     child: InkWell(
      //       borderRadius: BorderRadius.circular(16.h),
      //       onTap: () {
      //         NavigatorService.goBack();
      //       },
      //       child: Container(
      //         padding: EdgeInsets.all( 8.h),
      //         height: 50.h,
      //         width: 50.h,
      //         child: Material(
      //           type: MaterialType.transparency,
      //           child: InkWell(
      //             onTap: () {
      //               Navigator.of(context).pop();
      //             },
      //             child: CustomImageView(
      //               imagePath: Assets.images.btnBack,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
     body: BackgroundWidget(
        
        child: Column(
          children: [
            SizedBox(
              height: 120.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.h)
                  .copyWith(top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Settings',
                    style: theme.textTheme.displayLarge,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  _buildButton(
                    context,
                    text: 'Contact Us',
                    icon: Icons.person_2_outlined,
                    onTap: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => const SupportPopUp(
                          title: 'Contact',
                        ),
                      );
                    },
                    isTextWhite: true,
                    decoration: AppDecoration.primary,
                  ),
                  _buildButton(
                    context,
                    text: 'Rate us',
                    icon: Icons.star_border_outlined,
                    onTap: () async {
                      if (await InAppReview.instance.isAvailable()) {
                        await InAppReview.instance.requestReview();
                      }
                    },
                    isTextWhite: true,
                    decoration: AppDecoration.primary,
                  ),
                  _buildButton(
                    context,
                    text: 'Privacy Policy',
                    icon: Icons.lock_outlined,
                    onTap: () {
                      context.pushRoute(AgreementRoute(
                          arguments: AgreementScreenArguments(
                              agreementType: AgreementType.privacy)));
                    },
                    decoration: AppDecoration.primary,
                  ),
                  _buildButton(
                    context,
                    text: 'Terms of Use',
                    icon: Icons.article_outlined,
                    onTap: () {
                      context.pushRoute(AgreementRoute(
                          arguments: AgreementScreenArguments(
                              agreementType: AgreementType.terms)));
                    },
                    decoration: AppDecoration.primary,
                  ),
                  _buildButton(
                    context,
                    text: 'Version',
                    icon: Icons.info_outline,
                    onTap: () {
                      DialogHelper.showAppVersionDialog(context);
                    },
                    decoration: AppDecoration.primary,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context,
      {String text = '',
      Function()? onTap,
      Decoration? decoration,
      bool isTextWhite = false,
      IconData? icon}) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        decoration: AppDecoration.fillGray700,
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.h),
        margin: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            //   padding: EdgeInsets.all(10.h),
            //   child: Icon(icon ?? Icons.emoji_people),
            // ),
            // SizedBox(
            //   width: 8.h,
            // ),
            Text(
              text,
              style: theme.textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
