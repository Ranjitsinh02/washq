import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washq/common_widget/widget/snackBar_widget.dart';
import 'package:washq/logic/bloc/login_bloc/login_bloc.dart';
import 'package:washq/presentation/ui/forgot_password/reset_password/reset_password.dart';

import '../../../../common_widget/app_colors.dart';
import '../../../../common_widget/constants.dart';
import '../../../../common_widget/widget/heading_text_widget.dart';
import '../../../../common_widget/widget/logo_image_widget.dart';

class ResetOtpPassword extends StatefulWidget {
  static const routeName = '/resetOtpPassword';

  const ResetOtpPassword({Key? key}) : super(key: key);

  @override
  State<ResetOtpPassword> createState() => _ResetOtpPasswordState();
}

class _ResetOtpPasswordState extends State<ResetOtpPassword> {
  TextEditingController resetOtpPasswordController = TextEditingController();
  int isVisibleWidget = 0;
  String otpVerify = '';

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
                  text: Constants.resetPassword,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /*       Visibility(
                    visible: false,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextFormFieldWidget(
                        autofocus: true,
                        controller: resetPasswordController,
                        hintText: Constants.enterCode,
                        validator: (value) {
                          return null;
                        },
                      ),
                    ),
                  ),*/
                  Container(
                    padding: const EdgeInsets.only(
                      top: 18,
                      left: 20,
                    ),
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is VerifyOtpSuccess) {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return const ResetPassword();
                            },
                          ));
                        }
                      },
                      builder: (context, state) {
                        if (state is ForgotPasswordSuccess) {
                          otpVerify = state.otp;
                        }
                        return TextFormField(
                          onChanged: (value) {
                            if (kDebugMode) {
                              print("value:: $value");
                            }
                            /*if (value == otpValid) {
                              Navigator.pushReplacementNamed(
                                  context, ResetPassword.routeName);
                            }*/
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textFormFieldUnderLineColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors
                                      .textFormFieldFocusUnderLineColor),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textFormFieldUnderLineColor),
                            ),
                            focusColor: Colors.white,
                            fillColor: Colors.grey,
                            hintText: Constants.enterCode,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          controller: resetOtpPasswordController,
                          validator: (value) {
                            if (kDebugMode) {
                              print("value$value");
                            }
                            return value;
                          },
                          autofocus: true,
                          cursorColor: AppColors.textFormFieldCursorColor,
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 18, left: 0, right: 20),
                    child: TextButton(
                      onPressed: () {},
                      child: Column(
                        children: [
                          Visibility(
                            visible: true,
                            child: InkWell(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (resetOtpPasswordController.text
                                        .toString()
                                        .length !=
                                    6) {
                                  SnackBarWidget.buildErrorSnackBar(
                                      context, "Please enter valid otp");
                                }
                                BlocProvider.of<LoginBloc>(context).add(
                                    VerifyButtonPressed(
                                        verifyOtp:
                                            resetOtpPasswordController.text));
                              },
                              child: const Text(
                                Constants.verify,
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Visibility(
                              visible: false,
                              child: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Image.asset(
                                      'assets/images/check_mark.png'))),
                          const Visibility(
                            visible: false,
                            child: Text(
                              Constants.inValidCode,
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColorRed),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 18, left: 20, right: 20),
                child: TextButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    String email = BlocProvider.of<LoginBloc>(context).emailID;
                    BlocProvider.of<LoginBloc>(context)
                        .add(ForgotButtonPressed(emailId: email));
                  },
                  child: const Text(
                    Constants.reSendCode,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
