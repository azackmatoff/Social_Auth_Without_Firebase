import 'package:get_it/get_it.dart';
import 'package:socialauthenthication/modules/auth/repos/user_repository.dart';
import 'package:socialauthenthication/modules/auth/services/auth_services.dart';
import 'package:socialauthenthication/modules/auth/services/database_service.dart';

import 'modules/auth/viewmodels/user_view_model.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton(() => AuthServices());
  locator.registerLazySingleton(() => DatabaseService());
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => UserViewModel());
}
