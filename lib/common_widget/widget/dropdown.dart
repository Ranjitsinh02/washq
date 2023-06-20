import 'package:flutter/material.dart';
import 'package:washq/common_widget/app_colors.dart';

class DropDownWidget extends StatefulWidget {
  final String hintText;
  final List<String> itemsList;
  ValueChanged onChanged;
  String selectedValue;

  DropDownWidget(
      {Key? key,
      required this.hintText,
      required this.itemsList,
      required this.onChanged,
      required this.selectedValue})
      : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext _) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        // color: AppColors.dropdownBackgroundColor,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
            color: AppColors.cardBackGroundColor, style: BorderStyle.solid),
      ),
      child: DropdownButton(
        value: widget.selectedValue,
        icon: const Icon(Icons.keyboard_arrow_down_sharp),
        dropdownColor: AppColors.dropdownBackgroundColor,
        isExpanded: true,
        elevation: 50,
        hint: Text(widget.hintText),
        items: widget.itemsList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: widget.onChanged,

      ),
    );
  }
}
