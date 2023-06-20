import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washq/common_widget/app_colors.dart';
import 'package:washq/common_widget/constants.dart';
import 'package:washq/common_widget/row_text.dart';
import 'package:washq/common_widget/widget/heading_text_widget.dart';
import 'package:washq/common_widget/widget/logo_image_widget.dart';
import 'package:washq/logic/bloc/user_profile/profile_bloc.dart';

class UserProfileScreen extends StatefulWidget {
  static const routeName = '/ProfileScreen';

  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if(state is ProfileLoading){
            const CircularProgressIndicator();
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return _profileView(state);
        },
      ),
    );
  }

  Widget _profileView(ProfileState state) {
    return Container(
      // margin:
      //     EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.30),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LogoImageWidget(),
              _cardView(state),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardView(ProfileState state) {
    if(state is ProfileLoadSuccess){
      return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
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
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HeadingTextWidget(
                  text: "User Profile",
                ),
                Container(
                  padding: const EdgeInsets.only(top: 30),
                  child: RowTextWidget(
                    textHeading: 'Name:',
                    text: state.userProfileData[0].userName ?? "",
                  ),
                ),
               /* RowTextWidget(
                  textHeading: 'Name:',
                  text: 'User Name',
                ),*/
                RowTextWidget(
                  textHeading: 'Mobile number:',
                  text: state.userProfileData[0].userPhone ?? "",
                ),
                RowTextWidget(
                  textHeading: 'Email:',
                  text: state.userProfileData[0].userEmail ?? "",
                ),
                RowTextWidget(
                  textHeading: 'Hospital name:',
                  text: state.userProfileData[0].userHospital ?? "",
                ),
                RowTextWidget(
                  textHeading: 'Hospital type:',
                  text: state.userProfileData[0].userHospitalType ?? "",
                ),
                RowTextWidget(
                  textHeading: 'Hospital department:',
                  text: state.userProfileData[0].userHospitalDepartment ?? "",
                ),
                RowTextWidget(
                  textHeading: 'Designation:',
                  text: state.userProfileData[0].userHospitalDesignation ?? "",
                ),
              ],
            ),
          ),
        ),
      );
    }else{
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
