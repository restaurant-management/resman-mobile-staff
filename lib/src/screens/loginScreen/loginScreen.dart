import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authenticationBloc/bloc.dart';
import '../../blocs/authenticationBloc/state.dart';
import '../../blocs/loginBloc/bloc.dart';

//import '../dishesTodayScreen/dishesTodayScreen.dart';
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
  bool isLoading;

  final PageController controller = PageController();
  var currentPageValue = 0.0;

  AuthenticationBloc get _authenticationBloc => widget.authenticationBloc;

  @override
  void initState() {
//    _loginBloc = LoginBloc(authenticationBloc: _authenticationBloc);
    _loginBloc = LoginBloc();
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
//          Navigator.of(context).pushReplacement(
//            MaterialPageRoute(
//              builder: (BuildContext context) => DishesTodayScreen(),
//            ),
//          );
          print("Dang nhap thanh cong");
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
              itemCount: 2,
            ),
          ],
        ),
      ),
    );
  }
}
