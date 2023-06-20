import 'package:flutter/material.dart';
import 'package:washq/common_widget/app_colors.dart';

class SnackBarWidget {
  SnackBarWidget._();

  static buildErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.snackBarBackgroundColor,
      ),
    );
  }
}
