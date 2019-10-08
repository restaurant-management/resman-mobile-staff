import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'src/App.dart';

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App());
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}
