import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/registerBloc/bloc.dart';
import '../../../blocs/registerBloc/event.dart';
import '../../../blocs/registerBloc/state.dart';
import '../../../utils/validateEmail.dart';
import '../../../widgets/loadingButton.dart';
import 'loginButton.dart';
import 'loginTextInput.dart';

class SignUpForm extends StatefulWidget {
  final GestureTapCallback onTap;
  final RegisterBloc registerBloc;

  SignUpForm({this.onTap, @required this.registerBloc})
      : assert(registerBloc != null);

  @override
  State<StatefulWidget> createState() {
    return SignUpFormState();
  }
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _signUpKey = GlobalKey<LoadingButtonState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _autoValidate = false;

  GestureTapCallback get onTap => widget.onTap;

  RegisterBloc get registerBloc => widget.registerBloc;

  SignUpFormState();

  @override
  void initState() {
    registerBloc.dispatch(InitializeRegisterForm());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: registerBloc,
      listener: (BuildContext context, state) {
        if (state is RegisterFailure) {
          _signUpKey.currentState?.loadingComplete();
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }
        if (state is RegisterSuccess) {
          _signUpKey.currentState?.loadingComplete();
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Đăng ký thành công!'),
                backgroundColor: Theme.of(context).accentColor,
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
                  gradient: new LinearGradient(
                    colors: <Color>[
                      const Color.fromRGBO(88, 39, 176, 0.5),
                      const Color.fromRGBO(156, 39, 176, 0.6),
                      const Color.fromRGBO(0, 0, 0, 0.7),
                    ],
                    stops: [0.1, 0.5, 1.0],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/logo.png',
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Divider(color: Colors.transparent),
                      LoginTextInput(
                        controller: _usernameController,
                        hint: 'Tên đăng nhập',
                        icon: Icons.person_outline,
                        obscure: false,
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Vui lòng nhập tên đăng nhập của bạn!';
                        },
                      ),
                      Divider(color: Colors.transparent),
                      LoginTextInput(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        hint: 'Email',
                        icon: Icons.mail_outline,
                        obscure: false,
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Vui lòng nhập email của bạn!';

                          if(!validateEmail(value))
                            return 'Email chưa đúng';
                        },
                      ),
                      Divider(color: Colors.transparent),
                      LoginTextInput(
                        controller: _passwordController,
                        hint: 'Mật khẩu',
                        icon: Icons.lock_outline,
                        obscure: true,
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Vui lòng nhập thông tin vào trường này!';
                          if (value.length < 6)
                            return 'Mật khẩu phải lớn hơn 5 ký tự.';
                        },
                      ),
                      Divider(color: Colors.transparent),
                      LoginTextInput(
                        controller: _confirmPasswordController,
                        hint: 'Nhập lại mật khẩu',
                        icon: Icons.lock_outline,
                        obscure: true,
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Vui lòng nhập thông tin vào trường này!';
                          if (value != _passwordController.text)
                            return 'Mật khẩu không khớp';
                        },
                      ),
                      Divider(color: Colors.transparent),
                      LoginButton(
                        loadingKey: _signUpKey,
                        text: "Đăng ký",
                        onPressed: () {
                          if (_validateInputs()) {
                            registerBloc.dispatch(RegisterButtonPressed(
                              username: _usernameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                            ));
                          } else
                            _signUpKey.currentState?.loadingComplete();
                        },
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      InkWell(
                        child: Text(
                          'Đăng nhập',
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                        ),
                        onTap: onTap,
                      )
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

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
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
}
