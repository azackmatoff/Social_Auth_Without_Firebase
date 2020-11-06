import 'package:socialauthenthication/modules/auth/models/user_model.dart';

abstract class DatabaseBase {
  Future<bool> saveUser(UserModel user);
  Future<UserModel> getUser(String userID);
}
