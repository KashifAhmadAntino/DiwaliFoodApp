import 'package:flutter/material.dart';
import 'package:mvc_bolierplate_getx/core/constants/app_text_style.dart';
import 'package:mvc_bolierplate_getx/core/reponsive/SizeConfig.dart';

class SearchableDropdownWidget extends StatefulWidget {
  SearchableDropdownWidget({
    Key? key,
    required this.currrentSelectedValue,
    required this.titlesList,
    this.labelStyle,
    this.hintText,
  }) : super(key: key);

  String? currrentSelectedValue;
  final List<String> titlesList;
  TextStyle? labelStyle;
  String? hintText;

  @override
  State<SearchableDropdownWidget> createState() =>
      _SearchableDropdownWidgetState();
}

class _SearchableDropdownWidgetState extends State<SearchableDropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
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
              labelStyle: widget.labelStyle,
              hintStyle: AppTextStyle.greyMedium14,
              errorStyle:
                  const TextStyle(color: Colors.redAccent, fontSize: 16.0),
              hintText: widget.hintText ?? 'Select',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
          isEmpty: widget.currrentSelectedValue == null,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              icon: Icon(
                Icons.keyboard_arrow_down,
                size: 20 * SizeConfig.heightMultiplier!,
              ),
              value: widget.currrentSelectedValue,
              isDense: true,
              onChanged: (newValue) {
                setState(() {
                  widget.currrentSelectedValue = newValue as String;
                });
              },
              items: widget.titlesList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: AppTextStyle.greyMedium14,
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
