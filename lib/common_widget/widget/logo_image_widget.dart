import 'package:flutter/material.dart';
import 'package:washq/common_widget/constants.dart';

class LogoImageWidget extends StatelessWidget {
  const LogoImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.30,
        width: MediaQuery.of(context).size.width,
        child: Container(
            margin: const EdgeInsets.only(top: 50),
            padding: const EdgeInsets.all(0),
            child: Center(child: Image.asset(Constants.mainLogoImage))));
  }
}
