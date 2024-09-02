import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../core/app_export.dart';
import '../../../core/helpers/email_helper.dart';
import '../../../core/helpers/text_helper.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';

enum AgreementType {
  privacy,
  terms,
}

class AgreementScreenArguments {
  final AgreementType agreementType;
  final bool usePrivacyAgreement;

  AgreementScreenArguments({
    required this.agreementType,
    this.usePrivacyAgreement = false,
  });
}
@RoutePage()
class AgreementScreen extends StatefulWidget {
  final AgreementScreenArguments arguments;

  const AgreementScreen({super.key, required this.arguments});

  static Widget builder(
      BuildContext context, AgreementScreenArguments arguments) {
    return AgreementScreen(arguments: arguments);
  }

  factory AgreementScreen.create(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as AgreementScreenArguments;
    return AgreementScreen(arguments: arguments);
  }

  @override
  State<AgreementScreen> createState() => _AgreementScreenState();
}

class _AgreementScreenState extends State<AgreementScreen> {
  AgreementType get _agreementType => widget.arguments.agreementType;

  String get _agreementText => _agreementType == AgreementType.privacy
      ? TextHelper.privacy
      : TextHelper.terms;

  String get _title => _agreementType == AgreementType.privacy
      ? 'Privacy Policy'
      : 'Terms Of Use';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 80.h,
        leadingWidth: 50.h,
        leading: InkWell(
          // borderRadius: BorderRadiusStyle.circleBorder12,
          onTap: () {
            NavigatorService.goBack();
          },
          child: Container(
            padding: EdgeInsets.all(8.h),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          _title,
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // InkWell(
                  //   borderRadius: BorderRadiusStyle.circleBorder12,
                  //   onTap: () {
                  //     NavigatorService.goBack();
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.all(8.h),
                  //     child: CustomImageView(
                  //       imagePath: ImageConstant.imgArrowLeft,
                  //       color: theme.colorScheme.primary,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 10),
                  // Text(
                  //   _title,
                  //   style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  //         color: Theme.of(context).colorScheme.onBackground,
                  //         fontSize: 20
                  //       ),
                  // ),
                  SizedBox(height: 15),
                  Expanded(
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: 60),
                        physics: const BouncingScrollPhysics(),
                        child: MarkdownBody(
                          styleSheet: MarkdownStyleSheet(
                            h1: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                            h2: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                            h3: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                            h4: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  color: Colors.white,
                                ),
                            p: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                          data: _agreementText,
                          onTapLink: (text, href, title) =>
                              EmailHelper.launchEmailSubmission(
                            toEmail: text,
                            subject: '',
                            body: '',
                            errorCallback: () {},
                            doneCallback: () {},
                          ),
                          selectable: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
