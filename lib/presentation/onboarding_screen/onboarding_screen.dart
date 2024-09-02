import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pp_438/core/app_export.dart';
import 'package:pp_438/data/models/recipe_model/recipe.dart';
import 'package:pp_438/gen/assets.gen.dart';
import 'package:pp_438/presentation/additional_screens/add_recipe_screen.dart';
import 'package:pp_438/widgets/custom_elevated_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/services/database/database_keys.dart';
import '../../core/services/database/database_service.dart';
import '../../widgets/background_widget.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static Widget builder(BuildContext context) {
    return OnboardingScreen();
  }

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final _databaseService = GetIt.instance<DatabaseService>();
  String backImagePath = Assets.images.backgroundOnboarding1.path;

  final List<Map<String, dynamic>> _onboardingData = [
    {
      'image': Assets.images.onboarding1,
      'headText':
          'If you like to cook\ndelicious food, you\ndefinitely need your\nown cookbook',
      'fontSize': 50.0,
    },
    {
      'image': Assets.images.onboarding2,
      'headText': 'Save daily meals or\nwrite down secret\nrecipes',
      'fontSize': 50.0,
    },
    {
      'image': Assets.images.onboarding3,
      'headText': 'Let\'s Write down your\nfavorite recipe or create\nnew',
      'fontSize': 50.0,
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // padding: EdgeInsets.symmetric(horizontal: 16.h),

        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomImageView(
              imagePath: backImagePath,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 50.h),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    dotHeight: 12,
                    dotWidth: 12,
                    expansionFactor: 5,
                    dotColor: appTheme.gray600,
                    activeDotColor: theme.colorScheme.surface,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _onboardingData.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                          if (_currentPage == 2) {
                            backImagePath =
                                Assets.images.backgroundOnboarding2.path;
                          } else {
                            backImagePath =
                                Assets.images.backgroundOnboarding1.path;
                          }
                        });
                      },
                      itemBuilder: (context, index) {
                        return OnboardingPage(
                          image: _onboardingData[index]['image']!,
                          headText: _onboardingData[index]['headText']!,
                          isSecond: _currentPage == 0,
                          fontSize: _onboardingData[index]['fontSize']!,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 80.h,
                  ),
                  child: CustomElevatedButton(
                    text: _currentPage == 2 ? 'Start' : 'Next',
                    buttonStyle: CustomButtonStyles.fillRed,
                    onPressed: () => _next(),
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _next() async {
    if (_pageController.page == _onboardingData.length - 1) {
      context.pushRoute(AddRecipeRoute(recipe: Recipe.empty()));
      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return AddRecipeScreen(
      //       recipe: Recipe.empty(),
      //     );
      //   },
      // );
    } else {
      _databaseService.put(DatabaseKeys.seenOnboarding, true);
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }
}

class OnboardingPage extends StatelessWidget {
  final String headText;
  final String image;
  final bool isSecond;
  final double fontSize;

  const OnboardingPage(
      {Key? key,
      required this.headText,
      required this.image,
      this.isSecond = false,
      this.fontSize = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // fit: StackFit.expand,
        children: [
          SizedBox(height: 20.h),
          Expanded(
            child: Container(
              // height: 403.h,
              //  padding: EdgeInsets.only(bottom: 80.h),
              child: CustomImageView(
                // height: 350.h,
                //alignment: Alignment.bottomCenter,
                imagePath: image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Container(
            // height: 250.h,

            // height: 150.h,
            //   decoration: AppDecoration.fillWhiteA,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(headText,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.displayMediumOnPrimary_1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
