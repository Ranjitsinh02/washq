import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  final String text;
  Function() onPressed;

  TextButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          onPressed();
        },
        child: Row(
          children: [
            Text(text),
          ],
        ));
  }
}
