import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resman_mobile_staff/src/utils/gradientColor.dart';

import '../../../blocs/authenticationBloc/bloc.dart';
import '../../../blocs/loginBloc/bloc.dart';
import '../../../blocs/loginBloc/event.dart';
import '../../../blocs/loginBloc/state.dart';
import '../../../widgets/loadingButton.dart';
import 'loginButton.dart';
import 'loginTextInput.dart';

class LoginForm extends StatefulWidget {
  final GestureTapCallback onTap;
  final LoginBloc loginBloc;
  final AuthenticationBloc authenticationBloc;

  const LoginForm(
      {Key key,
      this.onTap,
      @required this.loginBloc,
      @required this.authenticationBloc})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _loginButton = GlobalKey<LoadingButtonState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final LoginState preState = LoginInitial();

  bool _autoValidate;

  LoginBloc get _loginBloc => widget.loginBloc;

  @override
  void initState() {
    _autoValidate = false;
    _loginBloc.dispatch(InitializeLoginForm());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginEvent, LoginState>(
      bloc: _loginBloc,
      listener: (
        BuildContext context,
        LoginState state,
      ) {
        if (state is LoginFailure) {
          _loginButton.currentState?.loadingComplete();
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }
      },
      child: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: GradientColor.of(
                    context,
                    alphaTopLeft: 125,
                    alphaBottomRight: 175,
                    alphaCenter: 180,
                  ).secondaryLinearGradient),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Hero(
                        tag: 'HeroLogoImage',
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 200,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Divider(color: Colors.transparent),
                      LoginTextInput(
                        controller: _usernameController,
                        hint: 'Email / Tên đăng nhập',
                        icon: Icons.person_outline,
                        keyboardType: TextInputType.emailAddress,
                        obscure: false,
                        // ignore: missing_return
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Vui lòng nhập thông tin vào trường này!';
                        },
                      ),
                      Divider(color: Colors.transparent),
                      LoginTextInput(
                        controller: _passwordController,
                        hint: 'Mật khẩu',
                        icon: Icons.lock_outline,
                        obscure: true,
                        // ignore: missing_return
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Vui lòng nhập thông tin vào trường này!';
                        },
                      ),
                      Divider(color: Colors.transparent),
                      LoginButton(
                        loadingKey: _loginButton,
                        text: "Đăng nhập",
                        onPressed: () {
                          if (_validateInputs()) {
                            _loginBloc.dispatch(
                              LoginButtonPressed(
                                usernameOrEmail: _usernameController.text,
                                password: _passwordController.text,
                              ),
                            );
                          } else {
                            _loginButton.currentState.loadingComplete();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _validateInputs() {
    bool result = _formKey.currentState.validate();
    if (!result) {
      setState(() {
        _autoValidate = true;
      });
    }
    return result;
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }
}
