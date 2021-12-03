import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:app_core/app_core.dart';

import 'injector.config.dart';

final injector = GetIt.instance;

@injectableInit
Future<Unit> setupInjector() async {
  await $initGetIt(injector);
  return unit;
}
