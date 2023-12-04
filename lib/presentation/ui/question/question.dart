import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washq/common_widget/app_helper.dart';
import 'package:washq/common_widget/widget/primary_button.dart';
import 'package:washq/data/model/question_model/question_model.dart';
import 'package:washq/logic/bloc/question_bloc/question_bloc.dart';
import 'package:washq/logic/bloc/user_profile/profile_bloc.dart';
import 'package:washq/presentation/ui/login/login_screen.dart';

import '../../../common_widget/app_colors.dart';
import '../../../common_widget/constants.dart';

class Questions extends StatefulWidget {
  static const routeName = '/questions';

  const Questions({Key? key}) : super(key: key);

  @override
  State<Questions> createState() => _QuestionState();
}

class _QuestionState extends State<Questions> {
  bool isChecked = false;
  String sectionName = '';
  List<QueOptions> selectedOption = [];
  List<String> questionData = [];

  Map<String, List<String>> selectedQuestionAnswer = {};
  Map<String,Map<String, List<String>>> sectionWiseQuestionAnswer = {};

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
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
                      AppHelper.clearSharePres();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ));
                    },
                    child: Image.asset(Constants.logoutImage)))
          ],
          backgroundColor: AppColors.appBarBackGroundColor),
      backgroundColor: AppColors.darkBlue,
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 80),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: AppColors.cardBackGroundColor,
              elevation: 15,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 60),
                      child: Text(
                        arg[Constants.sectionName],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppColors.textColorDarkBlue),
                      )),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 0, top: 20, right: 0),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: BlocConsumer<QuestionBloc, QuestionState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is QuestionLoading ||
                              state is QuestionInitial) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (state is QuestionLoaded) {
                            // selectedOption.clear();

                            return ListView.builder(
                                itemCount: state.questionModel.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              top: 30, left: 20, right: 20),
                                          child: Text(
                                            state.questionModel.data![index]
                                                .queTitle
                                                .toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.25,
                                          child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: state
                                                .questionModel
                                                .data![index]
                                                .queOptions!
                                                .length,
                                            itemBuilder: (context, ind) {
                                              return Container(
                                                margin: const EdgeInsets.only(
                                                    left: 20, right: 20),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: (){

                                                      },
                                                      child: Row(
                                                        children: [
                                                          Checkbox(
                                                              value: state.questionModel.data![index].queOptions![ind].isChecked,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  state.questionModel.data![index].queOptions![ind].isChecked = value!;
                                                                });

                                                                state.questionModel.data?.forEach((element) {
                                                                  List<String>elementQuestionsCheckedAnswersArray = [];
                                                                  if (selectedQuestionAnswer.isNotEmpty) {
                                                                    selectedQuestionAnswer.entries.forEach((mapElement) {
                                                                      if (mapElement.key == element.queId) {
                                                                        elementQuestionsCheckedAnswersArray.addAll(mapElement.value);
                                                                      }
                                                                    });
                                                                  }

                                                                  element.queOptions?.forEach((elements) {if (elements.isChecked == true) {
                                                                      if (!elementQuestionsCheckedAnswersArray.contains(elements.optionId)) {
                                                                        elementQuestionsCheckedAnswersArray.add(elements.optionId ?? "");
                                                                        selectedQuestionAnswer =
                                                                            {
                                                                          element.queId ?? "": elementQuestionsCheckedAnswersArray
                                                                        };

                                                                      }
                                                                    } else {
                                                                      if (elementQuestionsCheckedAnswersArray.contains(elements.optionId)) {
                                                                        elementQuestionsCheckedAnswersArray
                                                                            .remove(
                                                                                elements.optionId);
                                                                        selectedQuestionAnswer =
                                                                            {
                                                                          element.queId ??
                                                                                  "":
                                                                              elementQuestionsCheckedAnswersArray
                                                                        };
                                                                        sectionWiseQuestionAnswer =
                                                                            {
                                                                          arg[Constants.sectionIndex] ??
                                                                                  "":
                                                                              selectedQuestionAnswer
                                                                        };
                                                                      }
                                                                    }
                                                                  });
                                                                });
                                                              }),
                                                          Text(state
                                                                  .questionModel
                                                                  .data![
                                                                      index]
                                                                  .queOptions![
                                                                      ind]
                                                                  .optionTitle
                                                                  .toString() ??
                                                              ""),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          } else if (state is QuestionError) {
                            Text(state.error);
                          } else {
                            return Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: Center(
                                  child: Column(children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      child:
                                          Image.asset(Constants.categoryImage),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                    ),
                                    const Text("No Question Available"),
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
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    child: Image.asset(Constants.categoryImage),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.025,
                                  ),
                                  const Text("No Question1 Available"),
                                ]),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 25, bottom: 10),
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      gradient: const LinearGradient(colors: [
                        AppColors.circleFilledColor,
                        AppColors.darkBlue
                      ]),
                    ),
                    child: PrimaryButtonWidget(
                      text: Constants.save,
                      onPressed: () {

                        Map<String, List<Map<String, List<String>>>> questionsArray = {"questions": [selectedQuestionAnswer]};
                        Map<String, dynamic> sectionWiseQuestionAnswers = {arg[Constants.sectionIndex] : [questionsArray]};

                        print("QuestionOption:::${questionsArray})}");
                        print("QuestionOption:::${sectionWiseQuestionAnswers})}");
                        print("QuestionOption:::${selectedQuestionAnswer})}");
                        String hospitalId = context.read<ProfileBloc>().hospitalId;
                        String hospitalDept = context.read<ProfileBloc>().hospitalDepartment;

                        if(hospitalId == '' || hospitalDept == ''){
                          BlocProvider.of<ProfileBloc>(context).add(FetchUserDetails());
                        }
                        Navigator.of(context).pop(sectionWiseQuestionAnswers);
                        // BlocProvider.of<QuestionBloc>(context).add(SaveAnswerButtonPressed(answers: selectedOption, questionData: ));
                        // final modelData = context.read<QuestionBloc>().state.props;
                        // print("modelData${modelData.length}");
                        // print("modelData::${jsonEncode(modelData)}");
                        // Map<String,dynamic> data;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 50,
            right: 50,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 80,
                width: 80,
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                    child: Text(
                      "${15}/${20}",
                      style: TextStyle(
                        color: AppColors.textColorDarkBlue,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    // return ListView.builder(itemCount: 1,itemBuilder: (BuildContext context, int index){
    //   return
    // });
  }
}
