import 'package:flutter/material.dart';
import 'package:washq/common_widget/app_colors.dart';

class CheckBoxWidget extends StatefulWidget {
  final bool isChecked;
  ValueChanged onChanged;
  bool value;

  CheckBoxWidget({
    Key? key,
    this.isChecked = false,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  @override
  Widget build(BuildContext context) {
    /*Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.grey;
      }
      return AppColors.circleFilledColor;
    }*/

    return Checkbox(
      checkColor: Colors.white,
      activeColor: AppColors.circleFilledColor,
      // fillColor: MaterialStateProperty.resolveWith(getColor),
      value: widget.value,
      onChanged: widget.onChanged,
    );
  }
}
