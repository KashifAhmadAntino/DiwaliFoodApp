import 'package:flutter/material.dart';
import 'package:mvc_bolierplate_getx/core/constants/app_text_style.dart';
import 'package:mvc_bolierplate_getx/core/reponsive/SizeConfig.dart';

/// A form field Widget which will handle form ui.
///
/// [focusNode] : FocusNode for the form field.
/// [autoFocus] : Allow auto focus for the form field if true.
/// [textEditingController] : Text editing controller for the form field
///                           to handle the text change and other stuff.
/// [isObscureText] : If true it will make the form text secure.
/// [obscureCharacter] : If [isObscureText] true this will be used for the
///                      character which will be shown.
/// [textCapitalization] : Type of text capitalization for the form field.
// / [isFilled] : If true the decoration colors will be filled.
/// [contentPadding] : Padding for the form field between the content and
///                    boundary of the form.
/// [fillColor] : The background color of the form field.
/// [hintText] : The hint text of the form field.
/// [hintStyle] : The hint style for the the form field.
/// [errorStyle] : The error style for the the form field.
/// [formBorder] : The border for the form field.
/// [errorText] : The error text of the form field.
/// [suffixIcon] : The suffix pages of the form field.
/// [prefixIcon] : The prefix pages of the form field.
/// [textInputAction] : The text input action for the form filed.
/// [textInputType] : The keyboard type of the form field.
/// [formStyle] : The style of the form field. This will be used for the style
///               of the content.
// ignore: must_be_immutable
class FormFieldWidget extends StatelessWidget {
  FormFieldWidget({
    Key? key,
    this.focusNode,
    this.autoFocus = false,
    this.textEditingController,
    this.isObscureText = false,
    this.obscureCharacter = ' ',
    this.textCapitalization = TextCapitalization.none,
    this.maxLines,
    this.contentPadding,
    this.fillColor,
    this.hintText,
    this.hintStyle,
    this.errorStyle,
    this.formBorder,
    this.errorText,
    this.suffixIcon,
    this.prefixIcon,
    this.textInputAction = TextInputAction.done,
    this.textInputType = TextInputType.text,
    this.formStyle,
    this.onChange,
    this.isReadOnly = false,
    this.initialValue,
    this.onTap,
    this.suffixIconConstraints,
    this.onEditingComplete,
  }) : super(key: key);

  final FocusNode? focusNode;
  final bool autoFocus;
  final TextEditingController? textEditingController;
  final bool isObscureText;
  final String obscureCharacter;
  final TextCapitalization textCapitalization;
  final int? maxLines;
  EdgeInsets? contentPadding =
      EdgeInsets.all(15 * SizeConfig.heightMultiplier!);
  final Color? fillColor;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final OutlineInputBorder? formBorder;
  final String? errorText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final TextStyle? formStyle;
  final void Function(String value)? onChange;
  final bool isReadOnly;
  final String? initialValue;
  final Function()? onTap;
  final BoxConstraints? suffixIconConstraints;
  final VoidCallback? onEditingComplete;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            key: const Key('text-form-field'),
            readOnly: isReadOnly,
            autofocus: autoFocus,
            focusNode: focusNode,
            controller: textEditingController,
            initialValue: initialValue,
            obscuringCharacter: obscureCharacter,
            obscureText: isObscureText,
            textCapitalization: textCapitalization,
            onTap: onTap,
            maxLines: maxLines ?? 1,
            decoration: InputDecoration(
              suffixIconConstraints: suffixIconConstraints,
              focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(8 * SizeConfig.heightMultiplier!),
                  borderSide: const BorderSide(color: Colors.transparent)),
              enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(8 * SizeConfig.heightMultiplier!),
                  borderSide: const BorderSide(color: Colors.transparent)),
              errorBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(8 * SizeConfig.heightMultiplier!),
                  borderSide: const BorderSide(color: Colors.transparent)),
              disabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(8 * SizeConfig.heightMultiplier!),
                  borderSide: const BorderSide(color: Colors.transparent)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(8 * SizeConfig.heightMultiplier!),
                  borderSide: const BorderSide(color: Colors.transparent)),
              filled: true,
              contentPadding: contentPadding,
              fillColor: fillColor,
              border: formBorder,
              hintText: hintText,
              hintStyle: hintStyle ?? AppTextStyle.greyMedium14,
              errorText: errorText,
              errorStyle: errorStyle,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
            ),
            onChanged: onChange,
            onEditingComplete: onEditingComplete,
            textInputAction: textInputAction,
            keyboardType: textInputType,
            style: formStyle,
          ),
        ],
      );
}
