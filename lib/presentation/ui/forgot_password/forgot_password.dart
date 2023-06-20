import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washq/common_widget/widget/snackBar_widget.dart';
import 'package:washq/logic/bloc/login_bloc/login_bloc.dart';
import 'package:washq/presentation/ui/forgot_password/reset_password/reset_otp_password.dart';

import '../../../common_widget/app_colors.dart';
import '../../../common_widget/constants.dart';
import '../../../common_widget/widget/footer_widget.dart';
import '../../../common_widget/widget/heading_text_widget.dart';
import '../../../common_widget/widget/logo_image_widget.dart';
import '../../../common_widget/widget/primary_button.dart';
import '../../../common_widget/widget/text_form_field_widget.dart';
import '../sign_up/sign_up.dart';

class ForgotPassword extends StatefulWidget {
  static const String routeName = '/forgotPassword';

  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController forgotPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: _forgotPasswordView(),
    );
  }

  Widget _forgotPasswordView() {
    return Stack(
      // fit: StackFit.expand,
      children: [
        const Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: LogoImageWidget(),
        ),
        Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.30),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _cardView(),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: false,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FooterWidget(
              text: Constants.haveAnAccount,
              buttonText: Constants.signUp,
              onChanged: () {
                Navigator.pushNamed(context, SignUpScreen.routeName);
              },
            ),
          ),
        ),
        Padding(
            // this is new
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom)),
      ],
    );
  }

  Widget _cardView() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Card(
        elevation: 16,
        color: AppColors.cardBackGroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Container(
          margin:
              const EdgeInsets.only(top: 40, right: 10, left: 10, bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 30, left: 30),
                child: HeadingTextWidget(
                  text: Constants.forgotPasswordHeader,
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(right: 40, left: 40, top: 20),
                  child: const Text(
                    Constants.forgotScreenTextContainer,
                    textAlign: TextAlign.center,
                  )),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormFieldWidget(
                  controller: forgotPasswordController,
                  hintText: Constants.enterEmailAddress,
                  validator: (value) {
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 25),
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  gradient: const LinearGradient(colors: [
                    AppColors.circleFilledColor,
                    AppColors.darkBlue
                  ]),
                ),
                child: PrimaryButtonWidget(
                  text: Constants.submit,
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (forgotPasswordController.text.isEmpty) {
                      SnackBarWidget.buildErrorSnackBar(
                          context, Constants.pleaseEnterValidEmailId);
                    } else {
                      BlocProvider.of<LoginBloc>(context).add(
                          ForgotButtonPressed(
                              emailId: forgotPasswordController.text));
                       Navigator.pushNamed(context, ResetOtpPassword.routeName);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
