import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  List<Widget>? action;

  AppBarWidget({Key? key, required this.title, this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: action,),
    );
  }
}
