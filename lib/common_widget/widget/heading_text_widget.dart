import 'package:flutter/material.dart';

class HeadingTextWidget extends StatelessWidget {
  final String text;

  HeadingTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      textAlign: TextAlign.center,
      style:  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold,),
    );
  }
}
