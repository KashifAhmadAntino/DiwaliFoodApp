import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvc_bolierplate_getx/core/reponsive/SizeConfig.dart';

/// A pages which will be used in the forms to allow user to submit the
/// details which were filled by the user.
///
/// [onTap] : The tap event which will be triggered.
class FormSubmitWidget extends StatelessWidget {
  const FormSubmitWidget(
      {Key? key,
      required this.title,
      required this.onTap,
      this.titleStyle,
      this.buttonColor,
      this.height,
      this.width,
      this.prefixIcon,
      this.isDisable = false,
      this.borderRadius = 8})
      : super(key: key);

  final String? title;
  final TextStyle? titleStyle;
  final Color? buttonColor;
  final void Function()? onTap;
  final double? width;
  final double? height;
  final Widget? prefixIcon;
  final bool isDisable;
  final double borderRadius;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        height: height ?? 50 * SizeConfig.heightMultiplier!,
        constraints:
            BoxConstraints(maxWidth: width == null ? Get.width : width ?? 0),
        child: Container(
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(borderRadius)),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: isDisable ? Colors.grey.shade400 : buttonColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius))),
            onPressed: () {
              if (isDisable) {
              } else {
                onTap!();
              }
            },
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Padding(
                  padding: prefixIcon != null
                      ? EdgeInsetsDirectional.fromSTEB(
                          0,
                          0,
                          10 * SizeConfig.heightMultiplier!,
                          0,
                        )
                      : const EdgeInsets.all(0),
                  child: prefixIcon ?? Container(),
                ),
                Text(
                  title!,
                  overflow: TextOverflow.ellipsis,
                  style: titleStyle,
                ),
              ],
              // ),
            ),
          ),
        ),
      );
}
