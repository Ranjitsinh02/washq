import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washq/common_widget/app_colors.dart';
import 'package:washq/common_widget/app_common_widget.dart';
import 'package:washq/common_widget/app_helper.dart';
import 'package:washq/common_widget/constants.dart';
import 'package:washq/common_widget/widget/check_box_widget.dart';
import 'package:washq/common_widget/widget/footer_widget.dart';
import 'package:washq/common_widget/widget/heading_text_widget.dart';
import 'package:washq/common_widget/widget/logo_image_widget.dart';
import 'package:washq/common_widget/widget/primary_button.dart';
import 'package:washq/common_widget/widget/round_circle.dart';
import 'package:washq/common_widget/widget/snackBar_widget.dart';
import 'package:washq/common_widget/widget/text_form_field_widget.dart';
import 'package:washq/logic/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:washq/presentation/ui/login/login_screen.dart';
import 'package:washq/presentation/ui/sign_up/sign_up.dart';

class SignUpSecondScreen extends StatefulWidget {
  static const routeName = '/signupSecondScreen';

  const SignUpSecondScreen({Key? key}) : super(key: key);

  @override
  State<SignUpSecondScreen> createState() => _SignUpSecondScreenState();
}

class _SignUpSecondScreenState extends State<SignUpSecondScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  String hospitalName = '',
      hospitalType = '',
      hospitalDept = '',
      designation = '';

  bool isChecked = false, isPasswordShow = false, isConfirmPasswordShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                  Container(
                    margin: const EdgeInsets.only(top: 70),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.15),
        Align(
          alignment: Alignment.bottomCenter,
          child: FooterWidget(
            text: Constants.alreadyHaveAnAccount,
            buttonText: Constants.login,
            onChanged: () {
              Navigator.pushNamed(context, LoginScreen.routeName);
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
                text: Constants.createAnAccount,
              ),
              Container(
                  margin: const EdgeInsets.only(right: 10, left: 10),
                  child: _dividerStep()),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormFieldWidget(
                  controller: nameController,
                  hintText: Constants.enterName,
                  validator: (value) {},
                ),
              ),
              TextFormFieldWidget(
                controller: emailController,
                hintText: Constants.enterEmailAddress,
                validator: (value) {},
              ),
              TextFormFieldWidget(
                controller: passwordController,
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
                validator: (value) {},
              ),
              TextFormFieldWidget(
                controller: confirmPasswordController,
                hintText: Constants.enterConfirmPassword,
                isIconShow: true,
                obscureText: !isConfirmPasswordShow,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isConfirmPasswordShow = !isConfirmPasswordShow;
                      });
                    },
                    icon: Icon(
                      !isConfirmPasswordShow
                          ? Icons.visibility_off
                          : Icons.remove_red_eye,
                      color: AppColors.eyeIconsColor,
                    )),
                validator: (value) {},
              ),
              TextFormFieldWidget(
                keyBoardInputType: TextInputType.phone,
                controller: mobileNumberController,
                hintText: Constants.enterMobileNumber,
                validator: (value) {},
              ),
              Container(
                padding: const EdgeInsets.only(top: 20, left: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CheckBoxWidget(
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                      value: isChecked,
                    ),
                    const Text(Constants.termAndConditions),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  Navigator.pushNamed(context, SignUpScreen.routeName);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 20, left: 10),
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(Icons.keyboard_arrow_left),
                      Text(
                        Constants.back,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
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
                child: BlocConsumer<SignUpBloc, SignUpState>(
                  listener: (context, state) {
                    if (state is SignUpLoading) {
                      const CircularProgressIndicator();
                    } else if (state is SignUpFailure) {
                      // Text(state.error);
                      SnackBarWidget.buildErrorSnackBar(context, state.error);
                    } else if (state is SignUpSuccess) {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    }
                  },
                  builder: (context, state) {

                    return PrimaryButtonWidget(
                      text: Constants.signUp,
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        final arg =
                            ModalRoute.of(context)!.settings.arguments as Map;
                        hospitalName = arg[Constants.name];
                        hospitalType = arg[Constants.type];
                        hospitalDept = arg[Constants.department];
                        designation = arg[Constants.designation];

                        AppHelper.setHospitalType(arg[Constants.type]);
                        _validation();

                        // Navigator.pushNamed(context, HomeScreen.routeName);
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

  Widget _dividerStep() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Visibility(
          visible: false,
          child: Container(
            margin: const EdgeInsets.only(top: 20, left: 10, right: 6.0),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: RoundCircleShape(
                  text: Constants.one,
                  isFilledColor: true,
                )),
          ),
        ),
        Visibility(
          visible: true,
          child: Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.only(top: 15, left: 10),
            child: Align(
                alignment: Alignment.topLeft,
                child: Image.asset("assets/images/check_mark.png")),
          ),
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              top: 20.0,
              right: 6.0,
            ),
            child: Divider(
              color: AppColors.dividerColor,
              thickness: 1,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20, left: 3, right: 10),
          child: Align(
              alignment: Alignment.bottomLeft,
              child: RoundCircleShape(
                text: Constants.two,
                isFilledColor: true,
              )),
        ),
      ],
    );
  }

  void _validation() {
    if (kDebugMode) {
      print(emailController.text);
    }
    if (nameController.text == "") {
      SnackBarWidget.buildErrorSnackBar(context, Constants.pleaseEnterName);
    } else if (AppCommonWidget().isEmail(emailController.text) != true &&
        emailController.text == "") {
      SnackBarWidget.buildErrorSnackBar(
          context, Constants.pleaseEnterValidEmailId);
    } else if (AppCommonWidget().validatePassword(passwordController.text) !=
            true ||
        passwordController.text.length <= 8) {
      SnackBarWidget.buildErrorSnackBar(
          context, Constants.pleaseEnterValidPassword);
    } else if (passwordController.text != confirmPasswordController.text ||
        confirmPasswordController.text.length <= 8) {
      SnackBarWidget.buildErrorSnackBar(
          context, Constants.yourPasswordIsNotMatched);
    } else if (mobileNumberController.text.toString().length != 10) {
      SnackBarWidget.buildErrorSnackBar(
          context, Constants.pleaseEnterValidMobileNumber);
    } else if (isChecked == false) {
      SnackBarWidget.buildErrorSnackBar(
          context, Constants.pleaseCheckedTermCondition);
    } else {
      /*if (isChecked == true) {
        AppHelper.setUserLoginStatus(true);
      }*/

      BlocProvider.of<SignUpBloc>(context).add(SignUpButtonPressed(
        hospitalName: hospitalName,
        hospitalType: hospitalType,
        hospitalDept: hospitalDept,
        designation: designation,
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        mobileNumber: mobileNumberController.text,
        isChecked: isChecked,
      ));
    }
  }
}
