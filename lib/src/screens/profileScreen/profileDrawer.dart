import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/src/blocs/authenticationBloc/bloc.dart';
import 'package:resman_mobile_staff/src/blocs/authenticationBloc/event.dart';
import 'package:resman_mobile_staff/src/models/roleModel.dart';
import 'package:resman_mobile_staff/src/models/userModel.dart';
import 'package:resman_mobile_staff/src/respositories/responsitory.dart';

import '../editProfileScreen/editPasswordScreen.dart';
import '../editProfileScreen/editProfileScreen.dart';
import 'profileScreen.dart';

class ProfileDrawer extends StatefulWidget {
  final AuthenticationBloc authenticationBloc;
  const ProfileDrawer({Key key, @required this.authenticationBloc}) : super(key: key);

  @override
  _ProfileDrawerState createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfileDrawer> {
  Repository _repository = new Repository();
  @override
  Widget build(BuildContext context) {
    return Drawer(child: _buildContent(_repository.currentUser, _repository.currentUser.roles));
  }

  Widget _buildContent(UserModel user, List<RoleModel> allPermissions) {
    if(user == null) user = new UserModel.empty();
    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountEmail: Text(
            user.email ?? "Không có email",
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          accountName: Text(
            user.fullName ?? user.username ?? "Không có tên",
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
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
            Icons.description,
            color: Colors.pinkAccent,
          ),
          title: Text(
            'Hoá đơn của tôi',
            style: TextStyle(color: Colors.pinkAccent, fontSize: 16),
          ),
          onTap: () => Scaffold.of(context).openEndDrawer(),
        ),
        ListTile(
          leading: Icon(
            Icons.check_box,
            color: Colors.orange,
          ),
          title: Text(
            'Báo hết hàng',
            style: TextStyle(color: Colors.orange, fontSize: 16),
          ),
          onTap: () => Scaffold.of(context).openEndDrawer(),
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
            widget.authenticationBloc.dispatch(LoggedOut());
          },
        )
      ],
    );
  }
}
