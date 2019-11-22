import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'src/App.dart';

void main() {
  // Ensure all widgets were init
  WidgetsFlutterBinding.ensureInitialized();
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
