import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washq/common_widget/app_colors.dart';
import 'package:washq/common_widget/app_helper.dart';
import 'package:washq/common_widget/widget/primary_button.dart';
import 'package:washq/logic/bloc/home/home_bloc.dart';
import 'package:washq/logic/bloc/question_bloc/question_bloc.dart';
import 'package:washq/logic/bloc/sign_up_bloc/hospital_department_bloc/hospital_department_bloc.dart';
import 'package:washq/logic/bloc/sign_up_bloc/hospital_name_bloc/hospital_name_bloc.dart';
import 'package:washq/logic/bloc/user_profile/profile_bloc.dart';
import 'package:washq/presentation/ui/login/login_screen.dart';
import 'package:washq/presentation/ui/question/question.dart';
import 'package:washq/presentation/ui/user_profile/user_profile.dart';

import '../../../common_widget/constants.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isActive = false;
  bool isCompleted = false;
  Map<String, List<Object>> sectionWiseQuestionAnswer = {};
  Map<String, dynamic> submitAnswerArray = {};
  Object? questionAnswerObject;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    String token = await AppHelper.getToken();
    if (kDebugMode) {
      print(" HOme Page :: $token");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          leading: Container(
              margin: const EdgeInsets.only(left: 5),
              child: Image.asset(Constants.mainLogoImage)),
          actions: [
            Container(
                margin: const EdgeInsets.only(right: 15),
                width: 25,
                height: 25,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, UserProfileScreen.routeName);
                    },
                    child: Image.asset(Constants.userImage))),
            Container(
                margin: const EdgeInsets.only(right: 15),
                width: 25,
                height: 25,
                child: GestureDetector(
                    onTap: () {
                      AppHelper.clearSharePres();
                      /*AppHelper.setToken("");
                      AppHelper.setUserLoginStatus(false);*/
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ));
                    },
                    child: Image.asset(Constants.logoutImage)))
          ],
          backgroundColor: AppColors.appBarBackGroundColor),
      body: Stack(
        children: [
          BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is HomeLoading || state is HomeInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeLoaded) {
                return ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin:
                            const EdgeInsets.only(top: 5, right: 10, left: 10),
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Card(
                          elevation: 8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Image.asset(
                                          Constants.rightSignImage))),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        state.data[index].sectionName ?? '',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textColorDarkBlue),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                          "Progress ${15 ?? ''}/${20 ?? ''}")
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: !isCompleted
                                    ? Container(
                                        margin: const EdgeInsets.only(
                                            top: 3, right: 10),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.25,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          gradient: const LinearGradient(
                                              colors: [
                                                AppColors.circleFilledColor,
                                                AppColors.darkBlue
                                              ]),
                                        ),
                                        child: PrimaryButtonWidget(
                                            text: Constants.start,
                                            onPressed: () {
                                              BlocProvider.of<QuestionBloc>(
                                                      context)
                                                  .add(
                                                      SectionStartButtonPressed(
                                                hospitalId: state
                                                        .data[index].sectionId
                                                        .toString() ??
                                                    "",
                                              ));
                                              Navigator.pushNamed(
                                                  context, Questions.routeName,
                                                  arguments: {
                                                    Constants.sectionName: state
                                                        .data[index]
                                                        .sectionName,
                                                    Constants.sectionIndex:
                                                        state.data[index]
                                                            .sectionId,
                                                  }).then((elementValue) {
                                                questionAnswerObject =
                                                    elementValue;

                                                // submitAnswerArray = {"submit_answer" : [elementValue]};
                                                // print("submitAnswerArray:::$submitAnswerArray");
                                                print(
                                                    "questionAnswerObject:::$questionAnswerObject");
                                                /* if(elementValue != null){
                                                      for (var sectionElement in state.data) {
                                                        List<Object> questionList = [];
                                                        if(sectionWiseQuestionAnswer.isNotEmpty){
                                                          for (var element in sectionWiseQuestionAnswer.entries) {
                                                            if(element.key == sectionElement.sectionId){
                                                              questionList.addAll(element.value);
                                                              print("element.value${element.value}");
                                                            }
                                                          }
                                                        }
                                                        if(!questionList.contains(elementValue)){
                                                          print("element.value${sectionElement.sectionId}");
                                                          for (var element in sectionWiseQuestionAnswer.entries) {
                                                            if(element.key == sectionElement.sectionId){
                                                              questionList.addAll(element.value);
                                                              print("element.value${element.value}");
                                                            }}
                                                          questionList.add(elementValue);
                                                         sectionWiseQuestionAnswer = {sectionElement.sectionId ?? "": questionList};
                                                         print("object::$sectionWiseQuestionAnswer");
                                                        }else{
                                                          questionList.remove(elementValue);
                                                          sectionWiseQuestionAnswer = {sectionElement.sectionId ?? "": questionList};
                                                        }
                                                      }
                                                    }*/

                                                print(
                                                    "value:::${elementValue}");
                                              });
                                            }),
                                      )
                                    : Container(
                                        margin: const EdgeInsets.only(
                                            top: 3, right: 10),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.25,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          gradient: const LinearGradient(
                                              colors: [
                                                AppColors.darkBlue,
                                                AppColors.darkGreen
                                              ]),
                                        ),
                                        child: PrimaryButtonWidget(
                                            text: Constants.completed,
                                            onPressed: () {

                                            }),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else if (state is HomeError) {
                return Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Center(
                      child: Column(children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Image.asset(Constants.categoryImage),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        Text(state.error),
                      ]),
                    ),
                  ),
                );
              }
              return Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Center(
                    child: Column(children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Image.asset(Constants.categoryImage),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025,
                      ),
                      const Text("No Section Available"),
                    ]),
                  ),
                ),
              );
            },
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.12,
                width: MediaQuery.of(context).size.width,
                decoration: isCompleted
                    ? const BoxDecoration(
                        gradient: LinearGradient(colors: [
                        AppColors.circleFilledColor,
                        AppColors.darkBlue
                      ]))
                    : const BoxDecoration(color: AppColors.homeFooterColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Visibility(
                      visible: false,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "${Constants.totalScore} ${485}/${500}",
                          style: TextStyle(
                              color: AppColors.textColorBlack,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        Constants.homePageFooterText,
                        style: TextStyle(
                            color: AppColors.textColorBlack,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        gradient: isActive
                            ? const LinearGradient(colors: [
                                AppColors.circleFilledColor,
                                AppColors.darkBlue
                              ])
                            : const LinearGradient(
                                colors: [AppColors.white, AppColors.white]),
                      ),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              backgroundColor: isActive
                                  ? AppColors.transparent
                                  : AppColors.white),
                          onPressed: () {
                            String hospitalId =
                                context.read<ProfileBloc>().hospitalId;
                            String hospitalDept =
                                context.read<ProfileBloc>().hospitalDepartment;
                            print("hospitalName:::$hospitalId");
                            print("hospitalDept::$hospitalDept");

                            if (questionAnswerObject != null ||
                                hospitalDept.isNotEmpty ||
                                hospitalId.isNotEmpty) {
                              BlocProvider.of<HomeBloc>(context).add(
                                  OnSubmitQuestionAnswer(
                                      questionAnswer: [questionAnswerObject],
                                      hospitalId: hospitalId,
                                      hospitalDepartment: hospitalDept));
                            }
                          },
                          child: Text(
                            Constants.submit,
                            style: TextStyle(
                                color: isActive
                                    ? AppColors.textColorWhite
                                    : AppColors.grey),
                          )),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
