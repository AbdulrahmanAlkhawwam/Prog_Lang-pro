import 'package:get_it/get_it.dart';

import './core_services.dart';
import './auth_services.dart';
import './operations_services.dart';
import './wallets_services.dart';

final sl = GetIt.instance;

Future<void> initializeApp({bool firstInit = true}) async {
  await initializeCoreServices(sl, firstInit: firstInit);
  await initializeAuthServices(sl);
  // await initializeOperationServices(sl);
  // await initializeWalletServices(sl);
}
