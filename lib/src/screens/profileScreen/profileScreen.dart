// https://www.developerlibs.com/2018/08/flutter-collapsing-toolbar-layout.html
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/FakeData.dart';
import 'package:resman_mobile_staff/src/models/userModel.dart';

import '../../utils/outlineText.dart';
import '../editProfileScreen/editProfileScreen.dart';
import 'widgets/profileTab.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel user;

  const ProfileScreen({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  ScrollController scrollController;

   UserModel get user => widget.user;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: CustomScrollView(
          controller: scrollController,
          slivers: <Widget>[
            SliverAppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.mode_edit,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfileScreen()));
                  },
                ),
              ],
              expandedHeight: 300,
              floating: true,
              pinned: true,
              title: OutlineText(
                color: Colors.transparent,
                textColor: colors.colorScheme.onPrimary,
                text: user.fullName ?? user.username ?? "Không có tên",
              ),
              centerTitle: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: _buildAvatar(),
                background: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/login-background.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: new BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                    child: new Container(
                      decoration: new BoxDecoration(
                          color: Colors.white.withOpacity(0.0)),
                    ),
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  labelColor: colors.primaryColor,
                  unselectedLabelColor: colors.colorScheme.secondary,
                  tabs: [
                    Tab(
                      icon: Icon(Icons.assignment_ind),
                      text: "Thông tin",
                    ),
                    Tab(
                      icon: Icon(Icons.pin_drop),
                      text: "Mã giảm giá",
                    ),
                  ],
                ),
              ),
              pinned: true,
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: <Widget>[
                  ProfileTab(
                    user: user,
                  ),
                  Container(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    Widget avatarWidget = Container(
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
      width: 150.0,
      height: 150.0,
      padding: const EdgeInsets.all(2.0),
      decoration: new BoxDecoration(
        color: Colors.white, // border color
        shape: BoxShape.circle,
      ),
    );

    double scale = 1;
    if (scrollController.hasClients) {
      if (scrollController.offset != 0)
        scale = (150 - scrollController.offset) / 150;
      if (scale < 0) {
        scale = 0;
      }
    } else {
      scale = 1;
    }

    return new Transform(
      transform: new Matrix4.identity()..scale(scale, scale),
      alignment: Alignment.center,
      child: avatarWidget,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    scrollController.addListener(() => setState(() {}));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
