import 'package:flutter/material.dart';
import 'package:pp_438/core/app_export.dart';
import 'package:pp_438/core/helpers/image_helper.dart';
import 'package:pp_438/data/models/step_model/step_model.dart';

class StepWidget extends StatefulWidget {
  final StepModel step;
  final int index;

  const StepWidget({super.key, required this.step, required this.index});

  @override
  State<StepWidget> createState() => _StepWidgetState();
}

class _StepWidgetState extends State<StepWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
      decoration: AppDecoration.fillGray700.copyWith(
          color: appTheme.gray900,
          image: widget.step.photo.isNotEmpty
              ? DecorationImage(
                  image: MemoryImage(
                    ImageHelper.convertBase64ToFile(widget.step.photo!),
                  ),
                  fit: BoxFit.cover,
                )
              : null),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.step.name,
                        style: theme.textTheme.displaySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (widget.step.hour != 0 || widget.step.minute != 0)
                        Container(
                          width: 150.h,
                          decoration: AppDecoration.secondary,
                          padding:
                              EdgeInsets.symmetric(horizontal: 4.h, vertical: 2.h),
                          child: Row(
                            children: [
                              CustomImageView(
                                imagePath: Assets.images.timeFill,
                              ),
                              SizedBox(
                                width: 4.h,
                              ),
                              Flexible(
                                child: Row(
                                  children: [
                                    if (widget.step.hour != 0)
                                      Text(
                                        '${widget.step.hour} hour ',
                                        style: CustomTextStyles.bodySmallBlack900,
                                      ),
                                    if (widget.step.minute != 0)
                                      Text(
                                        '${widget.step.minute} min',
                                        style: CustomTextStyles.bodySmallBlack900,
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                Text(
                  widget.index.toString(),
                  style: CustomTextStyles.displayLargeRed300,
                ),
              ],
            ),
          ),
          Flexible(
            child: Text(
              widget.step.description,
              maxLines: 3,
              style: theme.textTheme.bodySmall,
              overflow:  TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
