import 'package:flutter/material.dart';
import 'package:flutter_taxi_user/Screen/History/history.dart';
import 'package:flutter_taxi_user/Screen/Home/home.dart';
import 'package:flutter_taxi_user/Screen/Login/login.dart';
import 'package:flutter_taxi_user/Screen/MyProfile/myProfile.dart';
import 'package:flutter_taxi_user/Screen/MyProfile/profile.dart';
import 'package:flutter_taxi_user/Screen/MyWallet/myWallet.dart';
import 'package:flutter_taxi_user/Screen/MyWallet/payment.dart';
import 'package:flutter_taxi_user/Screen/Notification/notification.dart';
import 'package:flutter_taxi_user/Screen/Request/request.dart';
import 'package:flutter_taxi_user/Screen/Settings/settings.dart';
import 'package:flutter_taxi_user/Screen/SignUp/signup.dart';
import 'package:flutter_taxi_user/Screen/UseMyLocation/useMyLocation.dart';
import 'package:flutter_taxi_user/Screen/Walkthrough/walkthrough.dart';

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({ WidgetBuilder builder, RouteSettings settings })
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (animation.status == AnimationStatus.reverse)
      return super.buildTransitions(context, animation, secondaryAnimation, child);
    return FadeTransition(opacity: animation, child: child);
  }
}

MaterialPageRoute getRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/home': return new MyCustomRoute(
      builder: (_) => new HomeScreen(),
      settings: settings,
    );
    case '/signup2': return new MyCustomRoute(
      builder: (_) => new SignUpScreen(),
      settings: settings,
    );
    case '/login': return new MyCustomRoute(
      builder: (_) => new LoginScreen(),
      settings: settings,
    );
    case '/walkthrough': return new MyCustomRoute(
      builder: (_) => new WalkthroughScreen(),
      settings: settings,
    );
    case '/use_my_location': return new MyCustomRoute(
      builder: (_) => new UseMyLocation(),
      settings: settings,
    );
    case '/payment_method': return new MyCustomRoute(
      builder: (_) => new PaymentMethod(),
      settings: settings,
    );
    case '/request': return new MyCustomRoute(
      builder: (_) => new RequestScreen(),
      settings: settings,
    );
    case '/my_wallet': return new MyCustomRoute(
      builder: (_) => new MyWallet(),
      settings: settings,
    );
    case '/history': return new MyCustomRoute(
      builder: (_) => new HistoryScreen(),
      settings: settings,
    );
    case '/notification': return new MyCustomRoute(
      builder: (_) => new NotificationScreens(),
      settings: settings,
    );
    case '/setting': return new MyCustomRoute(
      builder: (_) => new SettingsScreen(),
      settings: settings,
    );
    case '/profile': return new MyCustomRoute(
      builder: (_) => new Profile(),
      settings: settings,
    );
    case '/edit_prifile': return new MyCustomRoute(
      builder: (_) => new MyProfile(),
      settings: settings,
    );
    case '/logout': return new MyCustomRoute(
      builder: (_) => new LoginScreen(),
      settings: settings,
    );
    default:
      return new MyCustomRoute(
        builder: (_) => new HomeScreen(),
        settings: settings,
      );
  }
}
