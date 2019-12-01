import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resman_mobile_staff/src/blocs/currentUserBloc/bloc.dart';
import 'package:resman_mobile_staff/src/blocs/currentUserBloc/state.dart';
import 'package:resman_mobile_staff/src/common/EnvVariables.dart';
import 'package:resman_mobile_staff/src/screens/homeScreen/homeScreenChef.dart';
import 'package:resman_mobile_staff/src/screens/homeScreen/homeScreenStaff.dart';
import 'package:resman_mobile_staff/src/screens/homeScreen/homeScreenWareManager.dart';

import '../../blocs/authenticationBloc/bloc.dart';
import '../../blocs/authenticationBloc/state.dart';
import '../../blocs/loginBloc/bloc.dart';

import 'widgets/imageBackground.dart';
import 'widgets/loginForm.dart';

class LoginScreen extends StatefulWidget {
  final AuthenticationBloc authenticationBloc;

  const LoginScreen({Key key, @required this.authenticationBloc})
      : assert(authenticationBloc != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _loginBloc;
  CurrentUserBloc _currentUserBloc;
  bool isLoading;

  final PageController controller = PageController();
  var currentPageValue = 0.0;

  AuthenticationBloc get _authenticationBloc => widget.authenticationBloc;

  @override
  void initState() {
    _loginBloc = LoginBloc(authenticationBloc: _authenticationBloc);
    _currentUserBloc = CurrentUserBloc();
    isLoading = false;
    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page;
      });
    });
    return BlocListener(
      bloc: _authenticationBloc,
      listener: (BuildContext context, state) {
        if (state is AuthenticationAuthenticated) {
          BlocListener(
            bloc: _currentUserBloc,
            listener: (BuildContext context, state) {
              if (state is CurrentUserProfileFetched) {
                state.user.roles.forEach(
                      (role) {
                    if (role.slug == EnvVariables.StaffRole) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => HomeScreenStaff(),
                        ),
                      );
                    } else if (role.slug == EnvVariables.ChefRole) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => HomeScreenChef(),
                        ),
                      );
                    }else if (role.slug == EnvVariables.WareManagerRole) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => HomeScreenWareManager(),
                        ),
                      );
                    }
                  },
                );
              }

//              this.setState(() => {
//                loading = true;
//              })
            },
          );

        }
        if (state is AuthenticationLoading) {
          setState(() {
            isLoading = true;
          });
        }
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            ImageBackground(),
            PageView.builder(
              controller: controller,
              itemBuilder: (context, position) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..rotateY(currentPageValue - position)
                      ..rotateZ(currentPageValue - position),
                    child: LoginForm(
                      loginBloc: _loginBloc,
                      authenticationBloc: _authenticationBloc,
                      onTap: () {
                        controller.animateToPage(1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.decelerate);
                      },
                    ),
                  );
                },
              itemCount: 1,
            ),
          ],
        ),
      ),
    );
  }
}
