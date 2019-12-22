import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:resman_mobile_staff/src/blocs/currentUserBloc/bloc.dart';
import 'package:resman_mobile_staff/src/blocs/currentUserBloc/state.dart';
import 'package:resman_mobile_staff/src/blocs/editProfileBloc/bloc.dart';
import 'package:resman_mobile_staff/src/blocs/editProfileBloc/event.dart';
import 'package:resman_mobile_staff/src/blocs/editProfileBloc/state.dart';
import 'package:resman_mobile_staff/src/models/userModel.dart';
import 'package:resman_mobile_staff/src/utils/gradientColor.dart';
import 'package:resman_mobile_staff/src/widgets/loadingIndicator.dart';

import '../../widgets/AppBars/backAppBar.dart';
import '../../widgets/drawerScaffold.dart';

class EditProfileScreen extends StatelessWidget {
  final CurrentUserBloc _currentUserBloc = CurrentUserBloc();

  @override
  Widget build(BuildContext context) {
    return DrawerScaffold(
        appBar: BackAppBar(
          showShoppingCart: false,
        ),
        body: BlocBuilder(
          bloc: _currentUserBloc,
          builder: (BuildContext context, CurrentUserState state) {
            if (state is CurrentUserProfileFetched)
              return EditProfileForm(
                currentUser: state.user,
              );
            return LoadingIndicator();
          },
        ));
  }
}

class EditProfileForm extends StatefulWidget {
  final UserModel currentUser;

  const EditProfileForm({Key key, @required this.currentUser})
      : assert(currentUser != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EditProfileState();
  }
}

class EditProfileState extends State<EditProfileForm> {
  String _name;
  String _phoneNumber;
  String _address;
  String _oldAvatar;
  File _newAvatar;
  DateTime _birthday;
  bool isSaving;
  final _birthdayTextFieldController = new TextEditingController();
  final EditProfileBloc _editProfileBloc = EditProfileBloc();

  UserModel get currentUser => widget.currentUser;

  @override
  void initState() {
    isSaving = false;
    _birthday = currentUser.birthday;
    _name = currentUser.fullName;
    _phoneNumber = currentUser.phoneNumber;
    _address = currentUser.address;
    _oldAvatar = currentUser.avatar;
    if (_birthday != null)
      _birthdayTextFieldController.text =
          DateFormat('dd/MM/yyyy').format(_birthday);
    super.initState();
  }

  Future pickImageByCamera() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _newAvatar = tempImage;
    });
  }

  Future pickImageByGallery() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _newAvatar = tempImage;
    });
  }

  @override
  void dispose() {
    _editProfileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return BlocListener(
      bloc: _editProfileBloc,
      listener: (BuildContext context, state) {
        if (state is EditProfileBlocSaved)
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('Cập nhật thành công.'),
              backgroundColor: Theme.of(context).accentColor,
            ),
          );
        if (state is EditProfileBlocSaveFailure)
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('Xảy ra lỗi trong quá trình cập nhật.'),
              backgroundColor: Colors.red,
            ),
          );
        if (state is EditProfileBlocUploadAvatarFailure)
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('Xảy ra lỗi trong tải lên ảnh đại diện.'),
              backgroundColor: Colors.red,
            ),
          );
        if (state is EditProfileBlocUploadingAvatar ||
            state is EditProfileBlocUploadedAvatar ||
            state is EditProfileBlocSaving)
          setState(() {
            isSaving = true;
          });
        else
          setState(() {
            isSaving = false;
          });
      },
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Stack(children: [
              Container(
                width: 200.0,
                height: 200.0,
                padding: const EdgeInsets.all(4.0),
                decoration: new BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: _newAvatar != null
                      ? Image.file(
                          _newAvatar,
                          fit: BoxFit.cover,
                        )
                      : _oldAvatar != null
                          ? Image.network(
                              _oldAvatar,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/default-avatar.jpg',
                              fit: BoxFit.cover,
                            ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: ClipOval(
                    child: RaisedButton(
                      color: Color.fromRGBO(0, 0, 0, 0.3),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoActionSheet(
                                title: Text('Chọn cách nhập ảnh:'),
                                actions: <Widget>[
                                  CupertinoActionSheetAction(
                                    child: Text('Máy ảnh'),
                                    onPressed: () {
                                      pickImageByCamera().then((value) {
                                        Navigator.pop(context, 'Cancel');
                                      });
                                    },
                                  ),
                                  CupertinoActionSheetAction(
                                    child: Text('Thư viện'),
                                    onPressed: () {
                                      pickImageByGallery().then((value) {
                                        Navigator.pop(context, 'Cancel');
                                      });
                                    },
                                  ),
                                ],
                                cancelButton: CupertinoActionSheetAction(
                                  child: Text('Huỷ chọn ảnh'),
                                  isDefaultAction: true,
                                  onPressed: () {
                                    Navigator.pop(context, 'Cancel');
                                  },
                                ),
                              );
                            });
                      },
                    ),
                  ),
                ),
              ),
            ]),
            Form(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                              initialValue: _name,
                              style: TextStyle(color: primaryColor),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.contact_mail,
                                  color: primaryColor,
                                ),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                labelText: 'Họ và tên',
                                labelStyle: TextStyle(color: primaryColor),
                              ),
                              onFieldSubmitted: (value) {
                                setState(() {
                                  _name = value;
                                });
                              },
                            ),
                            TextFormField(
                              initialValue: _phoneNumber,
                              style: TextStyle(color: primaryColor),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.dialer_sip,
                                    color: primaryColor,
                                  ),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  labelText: 'Số điện thoại',
                                  labelStyle: TextStyle(color: primaryColor)),
                            ),
                            GestureDetector(
                              onTap: () => _selectDate(context),
                              child: AbsorbPointer(
                                child: TextFormField(
                                  controller: _birthdayTextFieldController,
                                  enabled: false,
                                  style: TextStyle(color: primaryColor),
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.calendar_today,
                                        color: primaryColor,
                                      ),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(20, 15, 20, 15),
                                      labelText: 'Ngày sinh',
                                      labelStyle:
                                          TextStyle(color: primaryColor)),
                                ),
                              ),
                            ),
                            TextFormField(
                              initialValue: _address,
                              style: TextStyle(color: primaryColor),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.directions,
                                    color: primaryColor,
                                  ),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  labelText: 'Địa chỉ',
                                  labelStyle: TextStyle(color: primaryColor)),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            GradientButton(
                              increaseWidthBy: 50,
                              child: Text('Lưu'),
                              gradient: GradientColor.of(context)
                                  .primaryLinearGradient,
                              callback: () {
                                if (!isSaving)
                                  _editProfileBloc.add(SaveNewProfile(
                                    currentUser,
                                    _name,
                                    _birthday,
                                    _phoneNumber,
                                    _newAvatar != null ? _newAvatar : null,
                                    _address,
                                  ));
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
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _birthday ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2020));
    if (picked != null && picked != _birthday) {
      setState(() {
        _birthday = picked;
      });
      _birthdayTextFieldController.text =
          DateFormat('dd/MM/yyyy').format(_birthday);
    }
  }
}
