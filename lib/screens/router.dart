import 'package:flutter/cupertino.dart';
import 'package:messanger/models/arguments.dart';
import 'package:messanger/screens/splash_screen.dart';

import '../utils/constanst/constants.dart';
import 'auth_screen/sign_in_screen.dart';
import 'auth_screen/sign_up_screen.dart';
import 'users_list_screen/private_chat/private_chat_screen.dart';
import 'users_list_screen/users_list_screen.dart';

class Routers {
  static final Routers instance = Routers._();
  factory Routers() => instance;
  Routers._();
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Constants.signInScreen:
        return CupertinoPageRoute(
          builder: (context) => SignInScreen(),
        );
      case Constants.signUpScreen:
        return CupertinoPageRoute(
          builder: (context) => SignUpScreen(),
        );
      case Constants.uzchatUsersScreen:
        return CupertinoPageRoute(
          builder: (context) => UsersListScreen(),
        );
      case Constants.splashScreen:
        return CupertinoPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case Constants.privateChatScreen:
        return CupertinoPageRoute(
          builder: (context) => PrivateChatScreen(
            infoArgument: settings.arguments as Arguments,
          ),
        );
    }
  }
}
