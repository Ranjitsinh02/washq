import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washq/common_widget/app_colors.dart';
import 'package:washq/common_widget/constants.dart';
import 'package:washq/common_widget/widget/dropdown.dart';
import 'package:washq/common_widget/widget/footer_widget.dart';
import 'package:washq/common_widget/widget/heading_text_widget.dart';
import 'package:washq/common_widget/widget/logo_image_widget.dart';
import 'package:washq/common_widget/widget/round_circle.dart';
import 'package:washq/common_widget/widget/snackBar_widget.dart';
import 'package:washq/data/repository/sign_up/hospital_name/hospital_name_repo.dart';
import 'package:washq/logic/bloc/sign_up_bloc/designation_bloc/designation_bloc.dart';
import 'package:washq/logic/bloc/sign_up_bloc/designation_bloc/designation_state.dart';
import 'package:washq/logic/bloc/sign_up_bloc/hospital_department_bloc/hospital_department_bloc.dart';
import 'package:washq/logic/bloc/sign_up_bloc/hospital_name_bloc/hospital_name_bloc.dart';
import 'package:washq/logic/bloc/sign_up_bloc/hospital_name_bloc/hospital_name_event.dart';
import 'package:washq/logic/bloc/sign_up_bloc/hospital_type_bloc/hospital_type_bloc.dart';
import 'package:washq/presentation/ui/login/login_screen.dart';
import 'package:washq/presentation/ui/sign_up/sign_up_second.dart';

List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class SignUpScreen extends StatefulWidget {
  static const routeName = '/SignUpScreen';

  // final HospitalNameCubit cubit;

  const SignUpScreen({
    Key? key,
    /*required this.cubit*/
  }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final HospitalNameBloc hospitalNameBloc =
      HospitalNameBloc(repository: HospitalNameRepository());

  @override
  void initState() {
    // TODO: implement initState
    /*WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit=  context.read<HospitalNameCubit>();
      cubit.getHospitalName();
    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: BlocConsumer<HospitalNameBloc, HospitalNameState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is HospitalNameInitial || state is HospitalNameLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HospitalNameSuccess) {
            return BlocBuilder<HospitalTypeBloc, HospitalTypeState>(
              builder: (context, state) {
                if (state is HospitalTypeInitial ||
                    state is HospitalTypeLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HospitalTypeSuccess) {
                  return BlocBuilder<HospitalDepartmentBloc,
                      HospitalDepartmentState>(
                    builder: (context, state) {
                      if (state is HospitalDepartmentInitial ||
                          state is HospitalDepartmentLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is HospitalDepartmentLoaded) {
                        return BlocBuilder<DesignationBloc, DesignationState>(
                          builder: (context, state) {
                            if (state is DesignationInitial ||
                                state is DesignationLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (state is DesignationLoaded) {
                              return _signUpView();
                            }
                            return Center(
                              child: Container(
                                margin: const EdgeInsets.only(left: 20,right: 20),
                                height: MediaQuery.of(context).size.height * 0.25,
                                child: Column(
                                  children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.12,
                                    child: Image.asset(Constants.warningImage)),
                                 const Text(Constants.apiErrorMessage, style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return Center(
                        child: Container(
                          margin: const EdgeInsets.only(left: 20,right: 20),
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: Column(
                            children: [
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.12,
                                  child: Image.asset(Constants.warningImage)),
                              const Text(Constants.apiErrorMessage, style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: Container(
                    margin: const EdgeInsets.only(left: 20,right: 20),
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.12,
                            child: Image.asset(Constants.warningImage)),
                        const Text(Constants.apiErrorMessage, style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: Container(
              margin: const EdgeInsets.only(left: 20,right: 20),
              height: MediaQuery.of(context).size.height * 0.25,
              child: Column(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.12,
                      child: Image.asset(Constants.warningImage)),
                  const Text(Constants.apiErrorMessage, style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _signUpView() {
    return Stack(
      children: [
        const Positioned(right: 0, top: 0, left: 0, child: LogoImageWidget()),
        Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.30),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
            margin: const EdgeInsets.only(
              top: 20,
              right: 20,
              left: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HeadingTextWidget(text: Constants.createAnAccount),
                _dividerStep(),
                Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: BlocBuilder<HospitalNameBloc, HospitalNameState>(
                      builder: (context, state) {
                        if (state is HospitalNameSuccess) {
                          return DropDownWidget(
                            hintText: Constants.selectHospitalType,
                            itemsList: state.data,
                            onChanged: (value) {
                              BlocProvider.of<HospitalNameBloc>(context).add(
                                  SelectHospitalNameValue(
                                      hospitalName: value!));
                            },
                            selectedValue: state.selectedValue,
                          );
                        } else if (state is HospitalNameFailed) {
                          return Text(state.error);
                        }
                        return Container();
                      },
                    )),
                // HospitalName
                // HospitalNameDropDown(),
                /* Container(
                  padding: const EdgeInsets.only(top: 40),
                  child: BlocBuilder<HospitalNameCubit, HospitalNameState>(
                    builder: (context, state) {
                      if(state is HospitalNameInitial || state is HospitalNameLoading){
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      if (state is HospitalNameLoaded) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            // color: AppColors.dropdownBackgroundColor,
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                                color: AppColors.cardBackGroundColor,
                                style: BorderStyle.solid),
                          ),
                          child: DropdownButton<String>(
                            value: state.selectedItem,
                            icon: const Icon(Icons.keyboard_arrow_down_sharp),
                            dropdownColor: AppColors.dropdownBackgroundColor,
                            isExpanded: true,
                            elevation: 50,
                            items: state.hospitalNameItem
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    ))
                                .toList(),
                            onChanged: (newValue) {
                              context.read<HospitalNameCubit>().selectedOption(newValue.toString()!);
                              print(newValue);
                            },
                          ),
                        );

                        */ /*return DropDownWidget(
                          hintText: Constants.selectHospitalName,
                          itemsList: state.data,
                          onChanged: (newValue) {
                            print("value$newValue");
                             // selectedHospitalName = newValue!;
                            hospitalNameBloc
                                .add(SelectHospitalNameValue(newValue));
                          },
                          selectedValue: state.selectedValue ?? "",
                        );*/ /*
                      } else if (state is HospitalNameError) {
                        return Text(state.error);
                      } else {
                        // return SnackBarWidget.buildErrorSnackBar(context, "Something went wrong! Please try again after sometime!");
                        return Text(state.toString());
                      }
                    },
                  ),
                ),*/

                //HospitalType
                Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: BlocBuilder<HospitalTypeBloc, HospitalTypeState>(
                      builder: (context, state) {
                        if (state is HospitalTypeSuccess) {
                          return DropDownWidget(
                            hintText: Constants.selectHospitalType,
                            itemsList: state.data,
                            onChanged: (value) {
                              BlocProvider.of<HospitalTypeBloc>(context).add(
                                  SelectedHospitalTypeEvent(
                                      hospitalType: value!));
                            },
                            selectedValue: state.selectedValue,
                          );
                        } else if (state is HospitalTypeFailed) {
                          return Text(state.error);
                        }
                        return Container();
                      },
                    )),
                // HospitalDepartment/Ward
                BlocBuilder<HospitalDepartmentBloc, HospitalDepartmentState>(
                  builder: (context, state) {
                    if (state is HospitalDepartmentLoading ||
                        state is HospitalDepartmentInitial) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is HospitalDepartmentLoaded) {
                      return Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: DropDownWidget(
                            hintText: Constants.selectDepartmentWard,
                            itemsList: state.data,
                            onChanged: (value) {
                              BlocProvider.of<HospitalDepartmentBloc>(context)
                                  .add(SelectedHospitalDepartmentEvent(
                                      selectedDepartment: value!));
                            },
                            selectedValue: state.selectedValue,
                          ));
                    } else if (state is HospitalDepartmentError) {
                      return Text(state.error);
                    } else {
                      return Container();
                    }
                  },
                ),
                //Designation
                BlocBuilder<DesignationBloc, DesignationState>(
                  builder: (context, state) {
                    if (state is DesignationLoading ||
                        state is DesignationInitial) {
                      return const CircularProgressIndicator();
                    } else if (state is DesignationLoaded) {
                      return Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: DropDownWidget(
                            hintText: Constants.selectDesignation,
                            itemsList: state.data,
                            onChanged: (value) {
                              BlocProvider.of<DesignationBloc>(context).add(
                                  SelectedDesignationValueEvent(
                                      selectedDesignation: value!));
                            },
                            selectedValue: state.selectedValue,
                          ));
                    } else if (state is DesignationError) {
                      return Text(state.error);
                    } else {
                      return Container();
                    }
                  },
                ),
                //Next button
                GestureDetector(
                  onTap: () {
                    if (kDebugMode) {
                      print(context.read<HospitalNameBloc>().selectedValue);
                    }
                    // context.read<HospitalNameBloc>().selectedValue;
                    _validation();
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          Constants.next,
                          style: TextStyle(fontSize: 18),
                        ),
                        Icon(Icons.keyboard_arrow_right),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget _dividerStep() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Visibility(
          visible: true,
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
          visible: false,
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
              )),
        ),
      ],
    );
  }

  void _validation() {
    // select hospitalName
    String selectedHospitalName =
        context.read<HospitalNameBloc>().selectedValue;

    // select hospital type
    String dropDownType = context.read<HospitalTypeBloc>().selectedType;

    // select department / ward
    String dropDownDept = context.read<HospitalDepartmentBloc>().selectedValue;

    // select designation
    String dropDownDesignation = context.read<DesignationBloc>().selectedValue;

    if (selectedHospitalName ==
        context.read<HospitalNameBloc>().hospitalName.first) {
      SnackBarWidget.buildErrorSnackBar(
          context, Constants.pleaseSelectHospitalName);
    } else if (dropDownType ==
        context.read<HospitalTypeBloc>().hospitalTypeList.first) {
      SnackBarWidget.buildErrorSnackBar(
          context, Constants.pleaseSelectHospitalType);
    } else if (dropDownDept ==
        context.read<HospitalDepartmentBloc>().departmentList.first) {
      SnackBarWidget.buildErrorSnackBar(
          context, Constants.pleaseSelectHospitalDeptWard);
    } else if (dropDownDesignation ==
        context.read<DesignationBloc>().designationList.first) {
      SnackBarWidget.buildErrorSnackBar(
          context, Constants.pleaseSelectDesignation);
    } else {
      Navigator.pushNamed(context, SignUpSecondScreen.routeName, arguments: {
        Constants.name: selectedHospitalName,
        Constants.type: dropDownType,
        Constants.department: dropDownDept,
        Constants.designation: dropDownDesignation
      });
    }
  }
}
