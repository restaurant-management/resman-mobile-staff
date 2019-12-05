import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:resman_mobile_staff/src/models/userModel.dart';
import 'package:resman_mobile_staff/src/respositories/responsitory.dart';

import '../../widgets/AppBars/backAppBar.dart';
import '../../widgets/drawerScaffold.dart';

class EditProfileScreen extends StatelessWidget {
  Repository _repository = new Repository();
  @override
  Widget build(BuildContext context) {
    return DrawerScaffold(
        appBar: BackAppBar(
          showShoppingCart: false,
        ),
        body: EditProfileForm(
          currentUser: _repository.currentUser,
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
  String _email;
  String _oldAvatar;
  File _newAvatar;
  DateTime _birthday;
  bool isSaving;
  final _birthdayTextFieldController = new TextEditingController();

  UserModel get currentUser => widget.currentUser;

  @override
  void initState() {
    isSaving = false;
    _birthday = currentUser.birthday;
    _name = currentUser.fullName;
    _email = currentUser.email;
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return SingleChildScrollView(
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
                            initialValue: _email,
                            style: TextStyle(color: primaryColor),
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.mail,
                                  color: primaryColor,
                                ),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                labelText: 'Email',
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
                                    labelStyle: TextStyle(color: primaryColor)),
                              ),
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
                                !isSaving
                                    ? Color.fromRGBO(88, 39, 176, 1)
                                    : Color.fromRGBO(0, 0, 0, 0.3),
                                !isSaving
                                    ? Color.fromRGBO(0, 39, 176, 1)
                                    : Color.fromRGBO(0, 0, 0, 0.3),
                              ],
                              stops: [0.1, 1.0],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                            ),
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
