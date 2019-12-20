import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:resman_mobile_staff/src/blocs/authenticationBloc/bloc.dart';
import 'package:resman_mobile_staff/src/blocs/authenticationBloc/event.dart';
import 'package:resman_mobile_staff/src/blocs/changePasswordBloc/bloc.dart';
import 'package:resman_mobile_staff/src/blocs/changePasswordBloc/event.dart';
import 'package:resman_mobile_staff/src/blocs/changePasswordBloc/state.dart';

import 'package:resman_mobile_staff/src/models/userModel.dart';

import '../../widgets/AppBars/backAppBar.dart';
import '../../widgets/drawerScaffold.dart';

class EditPasswordScreen extends StatefulWidget {
  final UserModel currentUser;

  const EditPasswordScreen({Key key, @required this.currentUser})
      : assert(currentUser != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EditPasswordState();
  }
}

class EditPasswordState extends State<EditPasswordScreen> {
  bool isChanging = false;
  bool _autoValidate = false;

  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final ChangePasswordBloc _changePasswordBloc = ChangePasswordBloc();

  UserModel get currentUser => widget.currentUser;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return DrawerScaffold(
      appBar: BackAppBar(
        showShoppingCart: false,
      ),
      body: SingleChildScrollView(
        child: BlocListener(
          bloc: _changePasswordBloc,
          listener: (BuildContext context, state) {
            if (state is ChangePasswordBlocFailure) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            }
            if (state is ChangePasswordBlocChanged) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Đổi mật khẩu thành công, đang đăng xuất...'),
                backgroundColor: Theme.of(context).accentColor,
              ));
              Future.delayed(Duration(seconds: 2)).then((v) {
                AuthenticationBloc().add(LoggedOut());
              });
            }
            if (state is ChangePasswordBlocChanging) {
              setState(() {
                isChanging = true;
              });
            } else
              setState(() {
                isChanging = false;
              });
          },
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TextFormField(
                                controller: _oldPasswordController,
                                obscureText: true,
                                style: TextStyle(color: primaryColor),
                                // ignore: missing_return
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Vui lòng nhập mật khẩu cũ của bạn!';
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.vpn_key,
                                    color: primaryColor,
                                  ),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  labelText: 'Mật khẩu cũ',
                                  labelStyle: TextStyle(color: primaryColor),
                                ),
                              ),
                              TextFormField(
                                controller: _newPasswordController,
                                obscureText: true,
                                style: TextStyle(color: primaryColor),
                                // ignore: missing_return
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Vui lòng nhập mật khẩu mới!';
                                  if (value.length < 6)
                                    return 'Mật khẩu phải lớn hơn 5 ký tự.';
                                  if (value == _oldPasswordController.text)
                                    return 'Mật khẩu mới phải khác mật khẩu cũ.';
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: primaryColor,
                                  ),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  labelText: 'Mật khẩu mới',
                                  labelStyle: TextStyle(color: primaryColor),
                                ),
                              ),
                              TextFormField(
                                controller: _confirmPasswordController,
                                obscureText: true,
                                style: TextStyle(color: primaryColor),
                                // ignore: missing_return
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Vui lòng nhập lại mật khẩu mới!';
                                  if (value != _newPasswordController.text)
                                    return 'Mật khẩu mới không khớp';
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: primaryColor,
                                  ),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  labelText: 'Nhập lại mật khẩu',
                                  labelStyle: TextStyle(color: primaryColor),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              GradientButton(
                                increaseWidthBy: 50,
                                child: Text('Lưu'),
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    !isChanging
                                        ? Color.fromRGBO(88, 39, 176, 1)
                                        : Color.fromRGBO(0, 0, 0, 0.3),
                                    !isChanging
                                        ? Color.fromRGBO(0, 39, 176, 1)
                                        : Color.fromRGBO(0, 0, 0, 0.3),
                                  ],
                                  stops: [0.1, 1.0],
                                  begin: Alignment.bottomRight,
                                  end: Alignment.topLeft,
                                ),
                                callback: () {
                                  // TODO Validate _validateInputs()
                                  if (true) {
                                    if (!isChanging)
                                      _changePasswordBloc
                                          .add(ChangePasswordEvent(
                                        _oldPasswordController.text,
                                        _newPasswordController.text,
                                        currentUser,
                                      ));
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
            ],
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
}
