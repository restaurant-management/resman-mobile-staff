import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:resman_mobile_staff/src/models/userModel.dart';

class ProfileTab extends StatelessWidget {
  final UserModel user;

  const ProfileTab({Key key, @required this.user})
      : assert(user != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.contact_mail),
          title: Text(user.fullName ?? user.username),
        ),
        ListTile(
          leading: Icon(Icons.mail),
          title: Text(user.email),
        ),
        ListTile(
          leading: Icon(Icons.calendar_today),
          title: Text(user.birthday != null
              ? DateFormat('dd/MM/yyyy').format(user.birthday)
              : 'Chưa cập nhật'),
        ),
        ListTile(
          leading: Icon(Icons.directions),
          title: Text(user.address),
        ),
      ],
    );
  }
}
