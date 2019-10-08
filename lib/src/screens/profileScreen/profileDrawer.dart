import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:restaurant_management_mobile/src/blocs/currentUserBloc/bloc.dart';
//import 'package:restaurant_management_mobile/src/blocs/currentUserBloc/event.dart';
//import 'package:restaurant_management_mobile/src/blocs/currentUserBloc/state.dart';
import 'package:resman_mobile_staff/src/models/roleModel.dart';
import 'package:resman_mobile_staff/src/models/userModel.dart';

import '../../blocs/authenticationBloc/bloc.dart';
import '../../blocs/authenticationBloc/event.dart';
import '../../blocs/authenticationBloc/state.dart';
import '../editProfileScreen/editPasswordScreen.dart';
import '../editProfileScreen/editProfileScreen.dart';
import '../loginScreen/loginScreen.dart';
import 'profileScreen.dart';

class ProfileDrawer extends StatefulWidget {

  const ProfileDrawer({Key key})
        :super(key: key);

  @override
  _ProfileDrawerState createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfileDrawer> {

  @override
  Widget build(BuildContext context) {
    //Fake data
    Map<String, dynamic> userJson = jsonDecode('{"userId": 1,"uuid": "1","userName": "ThanhDuy","fullName": "Phan Thanh Duy","email": "abc@mail.com","password": "","avatar": "https://www.facebook.com/photo.php?fbid=679484192551191&set=a.127365384429744&type=3&theater","birthday": "1969-07-20 20:18:04Z","phoneNumber": 120382103821098,"address": "abc","roles":[{"slug":"update-paid-bill-status","name":"staff","description":"abczyx","level":3,"permission":["update-paid-bill-status"]}]}');
    UserModel user = UserModel.fromJson(userJson);
    print(user);
    return Drawer(
        child: _buildContent(user, user.roles)
      );
  }

  Widget _buildContent(UserModel user, List<RoleModel> allPermissions) {
    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountEmail: Text(user.email),
          accountName: Text(user.fullName ?? user.username),
          currentAccountPicture: GestureDetector(
            onTap: () {},
            child: Container(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                          user: user,
                        ),
                      ),
                    );
                  },
                  child: Hero(
                    tag: "avatarHero",
                    child: ClipOval(
                      child: user.avatar != null
                          ? FadeInImage.assetNetwork(
                        placeholder: 'assets/images/default-avatar.jpg',
                        fit: BoxFit.cover,
                        image: user.avatar,
                      )
                          : Image.asset(
                        'assets/images/default-avatar.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                width: 32.0,
                height: 32.0,
                padding: const EdgeInsets.all(2.0),
                decoration: new BoxDecoration(
                  color: Theme.of(context).primaryColor, // border color
                  shape: BoxShape.circle,
                )),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/cover.jpg'),
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.assignment,
            color: Colors.blue,
          ),
          title: Text(
            'Danh sách hoá đơn',
            style: TextStyle(color: Colors.blue, fontSize: 16),
          ),
          onTap: () {
          },
        ),
        ListTile(
          leading: Icon(
            Icons.description,
            color: Colors.pinkAccent,
          ),
          title: Text(
            'Hoá đơn của tôi',
            style: TextStyle(color: Colors.pinkAccent, fontSize: 16),
          ),
          onTap: () {
          },
        ),
        ListTile(
          leading: Icon(
            Icons.assignment_ind,
            color: Colors.teal,
          ),
          title: Text(
            'Sửa thông tin',
            style: TextStyle(color: Colors.teal, fontSize: 16),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditProfileScreen()));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.lock,
            color: Colors.deepPurple,
          ),
          title: Text(
            'Đổi mật khẩu',
            style: TextStyle(color: Colors.deepPurple, fontSize: 16),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditPasswordScreen(
                      currentUser: user,
                    )));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.keyboard_return,
            color: Colors.deepOrange,
          ),
          title: Text(
            'Đăng xuất',
            style: TextStyle(color: Colors.deepOrange, fontSize: 16),
          ),
          onTap: () {
          },
        )
      ],
    );
  }
}
