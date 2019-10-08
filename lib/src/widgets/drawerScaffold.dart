import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authenticationBloc/bloc.dart';
//import '../screens/cartScreen/cartDrawer.dart';
//import '../screens/profileScreen/ProfileDrawer.dart';

class DrawerScaffold extends StatefulWidget {
  final Widget body;
  final PreferredSizeWidget appBar;
  final Widget bottomNavigationBar;
  final Widget floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;

  final AuthenticationBloc _authenticationBloc = AuthenticationBloc();

  DrawerScaffold(
      {Key key,
        this.body,
        this.appBar,
        this.bottomNavigationBar,
        this.floatingActionButton,
        this.floatingActionButtonLocation})
      : super(key: key);

  @override
  _DrawerScaffoldState createState() => _DrawerScaffoldState();
}

class _DrawerScaffoldState extends State<DrawerScaffold> {
  AuthenticationBloc get authenticationBloc => widget._authenticationBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: authenticationBloc,
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: widget.appBar,
          body: widget.body,
          floatingActionButton: widget.floatingActionButton,
          floatingActionButtonLocation: widget.floatingActionButtonLocation,
          backgroundColor: Theme.of(context).colorScheme.background,
//          endDrawer: ProfileDrawer(
//            authenticationBloc: authenticationBloc,
//          ),
//          drawer: CartDrawer(),
//          bottomNavigationBar: widget.bottomNavigationBar,
        );
      },
    );
  }
}
