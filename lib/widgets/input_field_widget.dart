import 'package:flutter/material.dart';
import 'package:grocery_app/ressources/app_colors.dart';
import 'package:grocery_app/ressources/constants.dart';

class InputField extends StatelessWidget {
  InputField({
    required this.labelText,
    required this.icon,
    this.obscureText,
    required this.keyboardType,
    required this.value,
    this.suffixIcon,
    this.hasSuffix = false,
    this.hasIcon = true,
    required this.iconColor,
    this.hasMaxLine = false,
    this.hasShadow = true,
    this.isElevated = true,
    this.hasBorder = false,
    this.hasErrorOnField = false,
    this.isPhoneNumber = false,
    this.isDoubleOnLine = false,
    this.maxLine = 7,
    this.contentPadding = 18.0,
    required this.onChanged,
  }) : super();

  final String labelText;
  final IconData? icon;
  final bool? obscureText;
  final bool hasSuffix;
  final bool hasIcon;
  final bool isPhoneNumber;
  final Color iconColor;
  final bool hasMaxLine;
  final bool hasShadow;
  final bool hasBorder;
  final bool isElevated;
  final bool hasErrorOnField;
  final void Function(String) onChanged;
  final bool isDoubleOnLine;
  TextInputType keyboardType;
  Widget? suffixIcon;
  String value;
  int maxLine;
  double contentPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isDoubleOnLine ? Constants.screenWidth(context) / 2.6 : null,
      child: Material(
        elevation: isElevated ? 15.0 : 0.0,
        shadowColor: hasShadow ? Colors.grey[300] : null,
        shape: hasBorder
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
                side: BorderSide(
                    color: hasErrorOnField ? AppColors.primary : AppColors.grey,
                    width: 1),
              )
            : null,
        borderRadius: !hasBorder ? BorderRadius.circular(8.0) : null,
        color: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 15.0),
          child: Row(
            children: [
              isPhoneNumber
                  ? Container(
                      height: 29.0,
                      width: 1.0,
                      margin: const EdgeInsets.only(right: 8.0),
                      // padding: EdgeInsets.symmetric(horizontal: 1.0),
                      color: AppColors.grey,
                    )
                  : const SizedBox(),
              Expanded(
                child: TextFormField(
                  // focusNode:  _focusNode,
                  cursorColor: AppColors.primary,
                  initialValue: value,
                  onChanged: onChanged,
                  obscureText: obscureText ?? false,
                  autofocus: false,
                  maxLines: hasMaxLine ? maxLine : 1,
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                    suffixIcon: hasSuffix ? suffixIcon : null,
                    contentPadding: hasMaxLine
                        ? const EdgeInsets.only(bottom: 30.0, top: 19.0)
                        : EdgeInsets.symmetric(vertical: contentPadding),
                    icon: hasIcon
                        ? Icon(
                            icon,
                            color: iconColor,
                            size: 16.67,
                          )
                        : null,
                    // labelStyle: AppStyles.textStyle(
                    //     color: AppColors.grey300, size: 17.0),
                    hintText: labelText,
                    // hintStyle: AppStyles.textStyle(
                    //     color: AppColors.grey300, size: 17.0),
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
