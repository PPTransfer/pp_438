import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pp_438/widgets/app_button.dart';

import '../core/helpers/email_helper.dart';


class SupportPopUp extends StatefulWidget {
  final String title;
  const SupportPopUp({super.key, required this.title});

  @override
  State<SupportPopUp> createState() => _SupportPopUpState();
}

class _SupportPopUpState extends State<SupportPopUp> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() => EmailHelper.launchEmailSubmission(
        toEmail: 'oliverz12wr@hotmail.com',
        subject: widget.title,
        body: _controller.text,
        doneCallback: Navigator.of(context).pop,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          Text(
            widget.title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          SizedBox(height: 30),
          Expanded(
            child: CupertinoTextField(
              controller: _controller,
              padding: EdgeInsets.all(12),
              textAlignVertical: TextAlignVertical.top,
              placeholder: 'Your message',
        
            
              maxLines: 15,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border.all(
                  color: Theme.of(context).colorScheme.onSurface,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(13),
              ),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
              placeholderStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
          SizedBox(height: 50),
          ValueListenableBuilder(
            valueListenable: _controller,
            builder: (context, value, child) => AppButton(
              onPressed: _send,
              label: 'Send',
              isActive: value.text.isNotEmpty,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
