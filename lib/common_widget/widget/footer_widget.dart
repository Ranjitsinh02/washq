import 'package:flutter/material.dart';
import 'package:washq/common_widget/app_colors.dart';

class FooterWidget extends StatelessWidget {
  final String? text;
  final String? buttonText;
  VoidCallback? onChanged;

  FooterWidget({
    Key? key,
    this.text,
    this.buttonText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: AppColors.darkBlue),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              text ?? "",
              style: const TextStyle(color: AppColors.textColorWhite),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onChanged,
              child: Text(
                buttonText ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColorWhite),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
