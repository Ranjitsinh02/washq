import 'package:flutter/material.dart';

class RowTextWidget extends StatelessWidget {
  final String textHeading;
  final String text;

  const RowTextWidget({Key? key, required this.textHeading, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, left: 20, top: 18),
      child: Row(
        children: [
          Wrap(crossAxisAlignment: WrapCrossAlignment.end, children: [
            Text(
              textHeading,
            )
          ]),
          const Spacer(),
          Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
            Text(
              text,
            )
          ]),
        ],
      ),
    );
  }
}
