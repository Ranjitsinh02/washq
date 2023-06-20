import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washq/common_widget/app_colors.dart';
import 'package:washq/common_widget/constants.dart';
import 'package:washq/common_widget/widget/heading_text_widget.dart';
import 'package:washq/common_widget/widget/logo_image_widget.dart';
import 'package:washq/common_widget/widget/primary_button.dart';
import 'package:washq/common_widget/widget/text_form_field_widget.dart';
import 'package:washq/logic/bloc/login_bloc/login_bloc.dart';
import 'package:washq/presentation/ui/login/login_screen.dart';

import '../../../../common_widget/app_common_widget.dart';
import '../../../../common_widget/widget/snackBar_widget.dart';

class ResetPassword extends StatefulWidget {
  static const String routeName = '/resetPassword';

  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController resetPasswordController = TextEditingController();
  TextEditingController resetConfirmPasswordController =
      TextEditingController();

  bool isResetPassShow = false, isResetConfirmPassShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: _resetPassView(),
    );
  }

  Widget _resetPassView() {
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _cardView(),
                  Container(
                    margin: const EdgeInsets.only(top: 70),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.15),
      ],
    );
  }

  Widget _cardView() {
    return Container(
      margin: const EdgeInsets.only(right: 10, left: 10),
      child: Card(
        elevation: 16,
        color: AppColors.cardBackGroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Container(
          margin:
              const EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HeadingTextWidget(
                text: Constants.resetPassword,
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormFieldWidget(
                  controller: resetPasswordController,
                  hintText: Constants.enterNewPassword,
                  isIconShow: true,
                  obscureText: !isResetPassShow,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isResetPassShow = !isResetPassShow;
                        });
                      },
                      icon: Icon(
                        !isResetPassShow
                            ? Icons.visibility_off
                            : Icons.remove_red_eye,
                        color: AppColors.eyeIconsColor,
                      )),
                  validator: (value) {},
                ),
              ),
              TextFormFieldWidget(
                controller: resetConfirmPasswordController,
                hintText: Constants.enterNewConfirmPassword,
                isIconShow: true,
                obscureText: !isResetConfirmPassShow,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isResetConfirmPassShow = !isResetConfirmPassShow;
                      });
                    },
                    icon: Icon(
                      !isResetConfirmPassShow
                          ? Icons.visibility_off
                          : Icons.remove_red_eye,
                      color: AppColors.eyeIconsColor,
                    )),
                validator: (value) {},
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  gradient: const LinearGradient(colors: [
                    AppColors.circleFilledColor,
                    AppColors.darkBlue
                  ]),
                ),
                child: BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is ResetPasswordSuccess) {
                      SnackBarWidget.buildErrorSnackBar(context, state.message);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ));
                    }
                  },
                  builder: (context, state) {
                    return PrimaryButtonWidget(
                      text: Constants.confirm,
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (AppCommonWidget().validatePassword(
                                    resetPasswordController.text) !=
                                true ||
                            resetPasswordController.text.length <= 8) {
                          SnackBarWidget.buildErrorSnackBar(
                              context, 'Please enter valid password');
                        } else if (resetPasswordController.text !=
                                resetConfirmPasswordController.text ||
                            resetConfirmPasswordController.text.length <= 8) {
                          SnackBarWidget.buildErrorSnackBar(
                              context, 'Your password not matched');
                        } else {
                          BlocProvider.of<LoginBloc>(context).add(
                              ResetConfirmButtonPressed(
                                  password: resetPasswordController.text,
                                  confirmPassword:
                                      resetConfirmPasswordController.text));
                          // Navigator.pushNamed(context, LoginScreen.routeName);
                        }
                      },
                    );
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
