import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvVariables{
  static const String PrepsTokenKey = 'jwt-login-token';
  static const String PrepsUsernameOrEmail = 'logged-in-username-or-email';
  static const String PrepsCart = 'user-cart';

  //Url
  static String apiUrl = DotEnv().env['API_URL'];
  static String graphServer = DotEnv().env['GRAPH_URL'];

  // Role
  static const  String StaffRole = 'staff';
  static const String ChefRole = 'chef';
  static const String WareManagerRole = 'ware-manager';

}