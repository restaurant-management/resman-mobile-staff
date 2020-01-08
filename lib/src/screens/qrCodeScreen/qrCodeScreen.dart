// https://www.developerlibs.com/2018/08/flutter-collapsing-toolbar-layout.html
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:resman_mobile_staff/src/models/userModel.dart';
import 'package:resman_mobile_staff/src/utils/gradientColor.dart';
import 'package:resman_mobile_staff/src/widgets/AppBars/backAppBar.dart';
import 'package:resman_mobile_staff/src/widgets/drawerScaffold.dart';

import '../../utils/outlineText.dart';

class QRCodeScreen extends StatefulWidget {
  final UserModel user;

  const QRCodeScreen({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return QRCodeScreenState();
  }
}

class QRCodeScreenState extends State<QRCodeScreen> {

  UserModel get user => widget.user;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);
    return DrawerScaffold(
      appBar: BackAppBar(),
      body: Center(
        child: QrImage(
          data: widget.user?.uuid ?? "ERROR",
          version: QrVersions.auto,
          size: 350,
        ),
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
}
