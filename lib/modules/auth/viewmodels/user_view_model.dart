import 'package:flutter/material.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:socialauthenthication/modules/auth/models/user_model.dart';
import 'package:socialauthenthication/modules/auth/repos/user_repository.dart';
import 'package:socialauthenthication/modules/auth/services/auth_base.dart';
import 'package:socialauthenthication/modules/widgets/platform_alert_dialog.dart';
import '../../../locator.dart';

enum ViewState { IDLE, BUSY }

class UserViewModel extends ChangeNotifier implements AuthBase {
  ViewState _viewState = ViewState.IDLE;
  UserRepository _repository = locator<UserRepository>();

  UserModel _userModel;
  String wrongEmailMessage;
  String wrongPasswordMessage;

  UserModel get user => _userModel;

  ViewState get state => _viewState;

// to notify UI of ViewState's state changes we use notifyListeners()
  set state(ViewState value) {
    _viewState = value;
    notifyListeners();
  }

  @override
  Future<UserModel> currentUser() async {
    try {
      _viewState = ViewState.BUSY;
      _userModel = await _repository.currentUser();
      notifyListeners();
      if (_userModel != null) {
        return _userModel;
      } else {
        return null;
      }
    } catch (e) {
      print("Currentuser Error at UserViewModel: " + e.toString());
      return null;
    } finally {
      _viewState = ViewState.IDLE;
      notifyListeners();
    }
  }

  Future<bool> saveUser(UserModel user) async {
    // TODO: implement saveUser
    throw UnimplementedError();
  }

  Future<UserModel> getUser(String userID) async {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signInWithFacebook(BuildContext context) async {
    try {
      _viewState = ViewState.BUSY;
      notifyListeners();
      _userModel = await _repository.signInWithFacebook(context);
      if (_userModel != null) {
        return _userModel;
      } else {
        return null;
      }
    } catch (e) {
      print("signInWithFacebook Error at UserViewModel: " + e.toString());
      await PlatformAlertDialog(
        subject: "Авторизация не удалась",
        content: "Ошибка: ${e.toString()}",
        mainButtonText: "OK",
      ).choosePlatformToShowDialog(context);
      return null;
    } finally {
      _viewState = ViewState.IDLE;
      notifyListeners();
    }
  }

  @override
  Future<UserModel> signInWithInstagram(BuildContext context) async {
    try {
      _viewState = ViewState.BUSY;
      notifyListeners();
      _userModel = await _repository.signInWithInstagram(context);
      if (_userModel != null) {
        return _userModel;
      } else {
        return null;
      }
    } catch (e) {
      print("signInWithInstagram Error at UserViewModel: " + e.toString());
      await PlatformAlertDialog(
        subject: "Авторизация не удалась",
        content: "Ошибка: ${e.toString()}",
        mainButtonText: "OK",
      ).choosePlatformToShowDialog(context);
      return null;
    } finally {
      _viewState = ViewState.IDLE;
      notifyListeners();
    }
  }

  @override
  Future<UserModel> signInWithTelegram(BuildContext context) {
    // TODO: implement signInWithTelegram
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signInWithVK(BuildContext context, VKLogin vkPlugin) async {
    try {
      _viewState = ViewState.BUSY;
      notifyListeners();
      _userModel = await _repository.signInWithVK(context, vkPlugin);
      if (_userModel != null) {
        return _userModel;
      } else {
        return null;
      }
    } catch (e) {
      print("signInWithVK Error at UserViewModel: " + e.toString());
      await PlatformAlertDialog(
        subject: "Авторизация не удалась",
        content: "Ошибка: ${e.toString()}",
        mainButtonText: "OK",
      ).choosePlatformToShowDialog(context);
      return null;
    } finally {
      _viewState = ViewState.IDLE;
      notifyListeners();
    }
  }

  @override
  Future<UserModel> signInWithYandex() {
    // TODO: implement signInWithYandex
    throw UnimplementedError();
  }

  @override
  Future<bool> signOut(BuildContext context, VKLogin vkPlugin) async {
    try {
      _viewState = ViewState.BUSY;
      notifyListeners();
      bool _result = await _repository.signOut(context, vkPlugin);
      _userModel = null;
      return _result;
    } catch (e) {
      await PlatformAlertDialog(
        subject: "Ошибка при выходе",
        content: "Ошибка: ${e.toString()}",
        mainButtonText: "OK",
      ).choosePlatformToShowDialog(context);
      print("signOut Error at UserViewModel: " + e.toString());
      return false;
    } finally {
      _viewState = ViewState.IDLE;
      notifyListeners();
    }
  }
}
