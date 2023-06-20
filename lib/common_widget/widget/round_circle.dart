import 'package:flutter/material.dart';
import 'package:washq/common_widget/app_colors.dart';

class RoundCircleShape extends StatelessWidget {
  final String text;
  final bool isFilledColor;

  RoundCircleShape({Key? key, required this.text, this.isFilledColor = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
          color: !isFilledColor ? AppColors.white : AppColors.circleFilledColor,
          borderRadius: BorderRadius.circular(100)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: !isFilledColor ? AppColors.black : AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
