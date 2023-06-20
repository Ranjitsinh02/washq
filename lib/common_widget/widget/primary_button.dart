import 'package:flutter/material.dart';
import 'package:washq/common_widget/app_colors.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final String text;
  VoidCallback onPressed;

  PrimaryButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            backgroundColor: AppColors.transparent),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ));
  }
}
