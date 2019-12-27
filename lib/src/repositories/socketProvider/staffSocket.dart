import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/io_client.dart';
import 'package:meta/meta.dart';
import 'package:resman_mobile_staff/src/common/EnvVariables.dart';
import 'package:resman_mobile_staff/src/models/billModel.dart';
import 'package:resman_mobile_staff/src/models/cartDishModel.dart';
import 'package:resman_mobile_staff/src/models/cartModel.dart';
import 'package:resman_mobile_staff/src/models/dailyDishModel.dart';
import 'package:resman_mobile_staff/src/models/discountCodeModel.dart';
import 'package:resman_mobile_staff/src/repositories/dataProviders/billProvider.dart';
import 'package:resman_mobile_staff/src/repositories/dataProviders/dailyDishesProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';

class StaffSocket {
  static StaffSocket _singleton;

  static StaffSocket get instance {
    if (_singleton == null) {
      print('Initialize StaffSocket ...');
      _singleton = StaffSocket._internal();
    }
    return _singleton;
  }

  factory StaffSocket() {
    return instance;
  }

  StaffSocket._internal();


  Socket socket;

  Future<void> InitConnect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    socket = io(
      '${EnvVariables.apiUrl}/staff-bill',
      <String, dynamic>{
        'transports': ['websocket'],
        'extraHeaders': {'Authorization': prefs.getString(EnvVariables.PrepsTokenKey)}
      },
    );
  }
}
