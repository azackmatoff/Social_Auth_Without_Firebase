import 'package:socialauthenthication/modules/auth/models/user_model.dart';
import 'package:socialauthenthication/modules/auth/services/database_base.dart';

class DatabaseService implements DatabaseBase {
  @override
  Future<UserModel> getUser(String userID) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<bool> saveUser(UserModel user) {
    // TODO: implement saveUser
    throw UnimplementedError();
  }
}
