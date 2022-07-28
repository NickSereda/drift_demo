import 'package:drift_demo/main.dart';
import 'package:injectable/injectable.dart';

import 'package:drift_demo/injection.config.dart';


@injectableInit
void configureInjection() => $initGetIt(getIt);
