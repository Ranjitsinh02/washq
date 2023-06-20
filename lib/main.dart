import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washq/data/repository/home_repo/section_repo.dart';
import 'package:washq/data/repository/login_repository/login_repository.dart';
import 'package:washq/data/repository/question_repo/question_repo.dart';
import 'package:washq/data/repository/sign_up/hospital_dept/hospital_department_repo.dart';
import 'package:washq/data/repository/sign_up/hospital_name/hospital_name_repo.dart';
import 'package:washq/data/repository/sign_up/hospital_type/hospital_type_repo.dart';
import 'package:washq/data/repository/sign_up/sign_up.dart';
import 'package:washq/data/repository/user_profile/user_profile_repo.dart';
import 'package:washq/logic/bloc/home/home_bloc.dart';
import 'package:washq/logic/bloc/login_bloc/login_bloc.dart';
import 'package:washq/logic/bloc/question_bloc/question_bloc.dart';
import 'package:washq/logic/bloc/sign_up_bloc/designation_bloc/designation_bloc.dart';
import 'package:washq/logic/bloc/sign_up_bloc/hospital_department_bloc/hospital_department_bloc.dart';
import 'package:washq/logic/bloc/sign_up_bloc/hospital_name_bloc/hospital_name_bloc.dart';
import 'package:washq/logic/bloc/sign_up_bloc/hospital_name_bloc/hospital_name_event.dart';
import 'package:washq/logic/bloc/sign_up_bloc/hospital_type_bloc/hospital_type_bloc.dart';
import 'package:washq/logic/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:washq/presentation/ui/forgot_password/forgot_password.dart';
import 'package:washq/presentation/ui/forgot_password/reset_password/reset_otp_password.dart';
import 'package:washq/presentation/ui/forgot_password/reset_password/reset_password.dart';
import 'package:washq/presentation/ui/home/home_screen.dart';
import 'package:washq/presentation/ui/login/login_screen.dart';
import 'package:washq/presentation/ui/question/question.dart';
import 'package:washq/presentation/ui/sign_up/sign_up.dart';
import 'package:washq/presentation/ui/sign_up/sign_up_second.dart';
import 'package:washq/presentation/ui/splash_screen.dart';
import 'package:washq/presentation/ui/user_profile/user_profile.dart';

import 'data/repository/sign_up/designation_repo/designation_repo.dart';
import 'logic/bloc/user_profile/profile_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  runApp(
    MultiRepositoryProvider(providers: [
      RepositoryProvider<HospitalNameRepository>(
          create: (_) => HospitalNameRepository()),
      RepositoryProvider<HospitalTypeRepository>(
          create: (_) => HospitalTypeRepository()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<QuestionBloc>(
            create: (_) => QuestionBloc(repository: QuestionRepository())),
        BlocProvider<HospitalNameBloc>(
            create: (_) =>
                HospitalNameBloc(repository: HospitalNameRepository())
                  ..add(FetchHospitalName())),
        BlocProvider<HospitalTypeBloc>(
            create: (_) =>
                HospitalTypeBloc(repository: HospitalTypeRepository())
                  ..add(FetchHospitalTypeEvent())),
        BlocProvider<HospitalDepartmentBloc>(
            create: (_) => HospitalDepartmentBloc(
                repository: HospitalDepartmentRepository())
              ..add(FetchHospitalDepartmentEvent())),
        BlocProvider<DesignationBloc>(
            create: (_) => DesignationBloc(repository: DesignationRepository())
              ..add(FetchDesignationEvent())),
        BlocProvider<SignUpBloc>(
          create: (_) => SignUpBloc(repository: SignUpRepository()),
        ),
        BlocProvider<LoginBloc>(
            create: (_) => LoginBloc(loginRepository: LoginRepository())),
        BlocProvider<HomeBloc>(
            create: (_) => HomeBloc(
                  repository:
                      SectionRepository(), /*questionBloc: QuestionBloc(repository: QuestionRepository())*/
                )..add(FetchHomeData())),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(profileRepo: UserProfileRepo())..add(FetchUserDetails()),
        )
        /* BlocProvider<HospitalNameCubit>(
          create: (_) => HospitalNameCubit(repository: HospitalNameRepository()),
        )*/
      ],
      child: MaterialApp(
        title: 'WashQ',
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'montserrat'),
        home: const SplashScreen(),
        routes: {
          SplashScreen.routeName: (_) => const SplashScreen(),
          SignUpScreen.routeName: (_) => const SignUpScreen(),
          SignUpSecondScreen.routeName: (_) => const SignUpSecondScreen(),
          LoginScreen.routeName: (_) => const LoginScreen(),
          ForgotPassword.routeName: (_) => const ForgotPassword(),
          ResetOtpPassword.routeName: (_) => const ResetOtpPassword(),
          ResetPassword.routeName: (_) => const ResetPassword(),
          HomeScreen.routeName: (_) => const HomeScreen(),
          Questions.routeName: (_) => const Questions(),
          UserProfileScreen.routeName: (_) => UserProfileScreen(),
        },
      ),
    );
  }

  /*late AppLifecycleState _notification;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _notification = state;
    });

    switch (state) {
      case AppLifecycleState.resumed:
        // TODO: Handle this case.

        break;
      case AppLifecycleState.inactive:
        // TODO: Handle this case.
        break;
      case AppLifecycleState.paused:
        // TODO: Handle this case.
        break;
      case AppLifecycleState.detached:
        // TODO: Handle this case.
        break;
    }*/
  // }
}
