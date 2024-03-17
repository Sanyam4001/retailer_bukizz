

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../ui/Login/Signin_Screen.dart';




class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name){
      case SignIn.route:
        return MaterialPageRoute(
          builder: (_) => const SignIn(),
        );
      // case SignUp.route:
      //   return MaterialPageRoute(
      //     builder: (_) => const SignUp(),
      //   );
      // case MainScreen.route:
      //   return MaterialPageRoute(
      //     builder: (_) => MainScreen()
      //   );
      // case ContactUsScreen.route:
      //   return MaterialPageRoute(
      //       builder: (_) => ContactUsScreen()
      //   );
      // case ViewDetailScreen.route:
      //   return MaterialPageRoute(
      //       builder: (_) => ViewDetailScreen()
      //   );
      // case AddressScreen1.route:
      //   return MaterialPageRoute(
      //       builder: (_) => AddressScreen1()
      //   );
      default:
        return _errorRoute();
    }
  }

  // handling the error
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text('Error: Invalid route'),
        ),
      ),
    );
  }
}


