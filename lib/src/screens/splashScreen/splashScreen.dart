import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resman_mobile_staff/src/screens/homeScreen/homeScreenChef.dart';
import 'package:resman_mobile_staff/src/screens/homeScreen/homeScreenStaff.dart';

import '../../blocs/authenticationBloc/bloc.dart';
import '../../blocs/authenticationBloc/event.dart';
import '../../blocs/authenticationBloc/state.dart';
import '../../widgets/animationLogo.dart';
import '../loginScreen/loginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  AuthenticationBloc authenticationBloc;

  @override
  void initState() {
    authenticationBloc = AuthenticationBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: authenticationBloc,
      listener: (BuildContext context, state) {
        if (state is AuthenticationAuthenticated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => HomeScreenStaff(),
            ),
          );
        }
        if (state is AuthenticationUnauthenticated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => LoginScreen(
                authenticationBloc: authenticationBloc,
              ),
            ),
          );
        }
      },
      child: Container(
        alignment: Alignment.center,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.9],
            colors: [
              Color(0xFFFC5C7D),
              Color(0xFF6A82FB),
            ],
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 90.0),
        child: Hero(
          tag: 'HeroLogoImage',
          child: AnimationLogo(
            animationTime: 1000,
            onAnimationCompleted: () {
              authenticationBloc.dispatch(AppStarted());
            },
          ),
        ),
      ),
    );
  }
}
