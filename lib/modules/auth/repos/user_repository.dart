import 'package:flutter/material.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:socialauthenthication/modules/auth/models/user_model.dart';
import 'package:socialauthenthication/modules/auth/services/auth_base.dart';
import 'package:socialauthenthication/modules/auth/services/auth_services.dart';
import 'package:socialauthenthication/modules/auth/services/database_service.dart';
import 'package:socialauthenthication/modules/widgets/platform_alert_dialog.dart';

import '../../../locator.dart';

enum DatabaseMode { FAKEDB, FIREBASEDB }

class UserRepository extends ChangeNotifier implements AuthBase {
  AuthServices _authService = locator<AuthServices>();
  DatabaseService _databaseService = locator<DatabaseService>();

  @override
  Future<UserModel> currentUser() async {
    return await _authService.currentUser();
  }

  Future<bool> saveUser(UserModel user) async {
    return await _databaseService.saveUser(user);
  }

  Future<UserModel> getUser(String userID) async {
    return await _databaseService.getUser(userID);
  }

  @override
  Future<bool> signOut(BuildContext context, VKLogin vkPlugin) async {
    try {
      return await _authService.signOut(context, vkPlugin);
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка при выходе: ${e.toString()}'),
        ),
      );
      return null;
    }
  }

  @override
  Future<UserModel> signInWithFacebook(BuildContext context) async {
    return await _authService.signInWithFacebook(context);
  }

  @override
  Future<UserModel> signInWithInstagram(BuildContext context) async {
    return await _authService.signInWithInstagram(context);
  }

  @override
  Future<UserModel> signInWithTelegram(BuildContext context) {
    // TODO: implement signInWithTelegram
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signInWithVK(BuildContext context, VKLogin vkPlugin) async {
    try {
      return await _authService.signInWithVK(context, vkPlugin);
    } catch (e) {
      print('signInWithVK error in repo: ${e.toString()}');
      await PlatformAlertDialog(
        subject: "Авторизация не удалась",
        content: "Ошибка: ${e.toString()}",
        mainButtonText: "OK",
      ).choosePlatformToShowDialog(context);
      return null;
    }
  }

  @override
  Future<UserModel> signInWithYandex() {
    // TODO: implement signInWithYandex
    throw UnimplementedError();
  }
}
