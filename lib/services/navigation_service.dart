import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(
    String routeName,
  ) {
    return navigatorKey.currentState!.pushNamed(
      routeName,
    );
  }

  Future<dynamic> navigateReplacementTo(
    String routeName,
  ) async {
    return await navigatorKey.currentState!.pushReplacementNamed(
      routeName,
    );
  }

  Future<dynamic> popAndReplace(
    String routeName,
  ) async {
    return await navigatorKey.currentState!.popAndPushNamed(
      routeName,
    );
  }

  Future<dynamic> popEndPush(
    String routeName,
  ) async {
    return await navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (route) => route.isFirst,
    );
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }
}
