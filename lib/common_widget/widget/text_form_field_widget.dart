import 'package:flutter/material.dart';
import 'package:washq/common_widget/app_colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator validator;
  final bool isIconShow;
  final bool autofocus;
  final bool obscureText;
  IconButton? suffixIcon;

  TextInputType? keyBoardInputType;

  TextFormFieldWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.isIconShow = false,
    this.obscureText = false,
    this.suffixIcon,
    this.keyBoardInputType,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 18, left: 20, right: 20),
      child: TextFormField(
        keyboardType: keyBoardInputType,
        // scrollPadding: const EdgeInsets.only(bottom: 200),
        decoration: InputDecoration(
          suffixIcon: isIconShow ? suffixIcon : null,
          enabledBorder: const UnderlineInputBorder(
            borderSide:
                BorderSide(color: AppColors.textFormFieldUnderLineColor),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide:
                BorderSide(color: AppColors.textFormFieldFocusUnderLineColor),
          ),
          border: const UnderlineInputBorder(
            borderSide:
                BorderSide(color: AppColors.textFormFieldUnderLineColor),
          ),
          focusColor: Colors.white,
          fillColor: Colors.grey,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        cursorColor: AppColors.textFormFieldCursorColor,
        autofocus: autofocus,
      ),
    );
  }
}
