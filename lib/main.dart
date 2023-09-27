import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:jokes/helper/app_constants.dart';
import 'package:jokes/helper/app_prefs.dart';
import 'package:jokes/jokes.dart';
import 'package:jokes/services/navigation_service.dart';
import 'package:jokes/services/network_util.dart';
import 'package:provider/provider.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

final GetIt locator = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await setupLocator();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarColor: AppConstants.primaryColor,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );

  runApp(const Jokes());
}

Future<void> setupLocator() async {
  final preferences = await StreamingSharedPreferences.instance;
  locator.registerLazySingleton<AppPrefs>(() => AppPrefs(preferences));
  locator.registerLazySingleton<NetworkUtil>(() => NetworkUtil());
  locator.registerLazySingleton(() => NavigationService());
}

extension ContextExtentions on BuildContext {
  double getHeight() => MediaQuery.of(this).size.height;
  double getWidth() => MediaQuery.of(this).size.width;
  MediaQueryData getQuery() => MediaQuery.of(this);

  Color white() => AppConstants.white;
  Color black() => AppConstants.black;
  Color primaryColor() => AppConstants.primaryColor;
  Color primaryColorLight() => const Color(0xff7457C4);
  Color subTitleColor() => const Color(0xff959595);
  Color dividerColor() => const Color(0xfff3f3f3);
  Color greyTextColor() => const Color(0xffD5D4D5);
  Color greenTextColor() => textGreenColor;
  Color darkTextColor() => const Color(0xff8f8f91);
  Color greyBgColor() => const Color(0xfff8f8f8);
  Color tealColor() => const Color(0xffD6F1E2);
  Color accentColor() => AppConstants.accentColor;
  Color greenColor() => const Color(0xff49C830);
  TextStyle customStyle({
    FontWeight? fontWeight,
    Color? color,
    double? size,
    TextDecoration? decoration,
    FontStyle? style,
  }) =>
      AppConstants.customNormal(
        color: color,
        size: size,
        weight: fontWeight,
        style: style,
      );
  TextStyle customFont({
    FontWeight? fontWeight,
    Color? color,
    double? size,
    TextDecoration? decoration,
  }) =>
      AppConstants.customNormal(
        color: color,
        size: size,
        weight: fontWeight,
      );
}
