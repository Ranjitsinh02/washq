import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washq/common_widget/app_colors.dart';
import 'package:washq/common_widget/app_helper.dart';
import 'package:washq/common_widget/constants.dart';
import 'package:washq/common_widget/widget/footer_widget.dart';
import 'package:washq/common_widget/widget/heading_text_widget.dart';
import 'package:washq/common_widget/widget/logo_image_widget.dart';
import 'package:washq/common_widget/widget/primary_button.dart';
import 'package:washq/common_widget/widget/snackBar_widget.dart';
import 'package:washq/common_widget/widget/text_form_field_widget.dart';
import 'package:washq/logic/bloc/login_bloc/login_bloc.dart';
import 'package:washq/presentation/ui/forgot_password/forgot_password.dart';
import 'package:washq/presentation/ui/home/home_screen.dart';
import 'package:washq/presentation/ui/sign_up/sign_up.dart';


class LoginScreen extends StatefulWidget {
  static const routeName = '/loginScreen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isPasswordShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: _signUpView(),
    );
  }

  Widget _signUpView() {
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
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: FooterWidget(
            text: Constants.haveAnAccount,
            buttonText: Constants.signUp,
            onChanged: () {
              Navigator.pushNamed(context, SignUpScreen.routeName);
            },
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
              const EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HeadingTextWidget(
                text: Constants.loginToYourAccount,
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormFieldWidget(
                  controller: loginEmailController,
                  hintText: Constants.enterEmailAddress,
                  validator: (value) {
                    return null;
                  },
                ),
              ),
              TextFormFieldWidget(
                controller: loginPasswordController,
                hintText: Constants.enterPassword,
                isIconShow: true,
                obscureText: !isPasswordShow,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordShow = !isPasswordShow;
                      });
                    },
                    icon: Icon(
                      !isPasswordShow
                          ? Icons.visibility_off
                          : Icons.remove_red_eye,
                      color: AppColors.eyeIconsColor,
                    )),
                validator: (value) {
                  return null;
                },
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(right: 20, left: 10, top: 15),
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: TextButton(
                    child: const Text(Constants.forgotPassword,
                        style: TextStyle(fontSize: 16)),
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Navigator.pushNamed(context, ForgotPassword.routeName);
                    },
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 18),
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
                    if(state is LoginFailed){
                      SnackBarWidget.buildErrorSnackBar(context, state.error);
                    }
                    if (state is LoginSuccess) {
                      // AppHelper.setToken(state.token);

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ));
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginFailed) {
                      Center(child: Text(state.error));
                    }
                    return PrimaryButtonWidget(
                      text: Constants.login,
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        validation();
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

  void validation() {
    if (loginEmailController.text.isEmpty) {
      SnackBarWidget.buildErrorSnackBar(
          context, Constants.pleaseEnterValidEmailId);
    } else if (loginPasswordController.text.isEmpty ||
        loginPasswordController.text.toString().length <= 8) {
      SnackBarWidget.buildErrorSnackBar(
          context, Constants.pleaseEnterValidPassword);
    } else {
      BlocProvider.of<LoginBloc>(context).add(LoginButtonOnPressed(
          emailId: loginEmailController.text,
          password: loginPasswordController.text));
      /* Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));*/
      // SnackBarWidget.buildErrorSnackBar(context, 'Click on Login button');
    }
  }
}
