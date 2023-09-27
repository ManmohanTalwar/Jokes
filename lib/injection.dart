// Package imports:
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'injection.config.dart';

final GetIt locator = GetIt.instance;

@injectableInit
void configureInjection(String env) {
  locator.init(environment: env);
}
