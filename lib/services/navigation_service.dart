import 'package:flutter/material.dart';

import '../models/arguments_model.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, [ScreenArguments? arguments]) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateReplacementTo(String routeName,
      [ScreenArguments? arguments]) async {
    return await navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> popAndReplace(String routeName,
      [ScreenArguments? arguments]) async {
    return await navigatorKey.currentState!
        .popAndPushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> popEndPush(String routeName,
      [ScreenArguments? arguments]) async {
    return await navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (route) => route.isFirst,
        arguments: arguments);
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }
}
