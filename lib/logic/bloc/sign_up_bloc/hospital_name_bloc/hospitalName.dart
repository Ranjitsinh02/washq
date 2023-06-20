import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common_widget/app_colors.dart';
import 'hospital_name_bloc.dart';
import 'hospital_name_event.dart';

class HospitalNameDropDown extends StatelessWidget {
  const HospitalNameDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HospitalNameBloc, HospitalNameState>(
        builder: (context, state) {
      if (state is HospitalNameLoading || state is HospitalNameInitial) {
        return const CircularProgressIndicator();
      } else if (state is HospitalNameSuccess) {
        return Container(
          padding: const EdgeInsets.only(top: 40),
          child: BlocBuilder<HospitalNameBloc, HospitalNameState>(
            builder: (context, state) {
              if (state is HospitalNameSuccess) {
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
                    value: state.selectedValue,
                    icon: const Icon(Icons.keyboard_arrow_down_sharp),
                    dropdownColor: AppColors.dropdownBackgroundColor,
                    isExpanded: true,
                    elevation: 50,
                    items: state.data
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      BlocProvider.of<HospitalNameBloc>(context).add(
                          SelectHospitalNameValue(hospitalName: newValue!));
                    },
                  ),
                );
              } else if (state is HospitalNameFailed) {
                return Text(state.error);
              } else {
                // return SnackBarWidget.buildErrorSnackBar(context, "Something went wrong! Please try again after sometime!");
                return Text(state.toString());
              }
            },
          ),
        );
      }
      return Container();
    });
  }
}
