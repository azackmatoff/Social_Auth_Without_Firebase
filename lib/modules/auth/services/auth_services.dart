import 'package:flutter/material.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:socialauthenthication/modules/auth/models/user_model.dart';
import 'package:socialauthenthication/modules/auth/services/auth_base.dart';
import 'package:socialauthenthication/modules/widgets/platform_alert_dialog.dart';

class AuthServices implements AuthBase {
  @override
  Future<UserModel> currentUser() {
    // TODO: implement currentUser
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signInWithInstagram() {
    // TODO: implement signInWithInstagram
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signInWithTelegram() {
    // TODO: implement signInWithTelegram
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signInWithVK(BuildContext context, VKLogin vkPlugin) async {
    final res = await vkPlugin.logIn(scope: [
      VKScope.email,
    ]);

    if (res.isError) {
      print("signInWithVK in Auth Service" + res.isError.toString());
      await PlatformAlertDialog(
        subject: "Авторизация не удалась",
        content: "Ошибка: ${res.asError.error.toString()}",
        mainButtonText: "OK",
      ).choosePlatformToShowDialog(context);
      return null;
    } else {
      final loginResult = res.asValue.value;
      if (!loginResult.isCanceled) {
        print("VK login result $loginResult");
        final token = await vkPlugin.accessToken;
        final profileRes =
            token != null ? await vkPlugin.getUserProfile() : null;
        final email = token != null ? await vkPlugin.getUserEmail() : null;
        final profile = profileRes?.asValue?.value;
        return UserModel(
          accesToken: token.toString(),
          email: email ?? 'В профиле VK не зарегистрирован адрес э-почты',
          userID: profile.userId.toString(),
          username: profile.firstName.toString().toLowerCase(),
          profileURL: profile.photo200.toString(),
          firstName: profile.firstName?.toString(),
          lastName: profile.lastName?.toString(),
        );
      } else {
        await PlatformAlertDialog(
          subject: "Вход отменен",
          content: "Вы отменили авторизацию",
          mainButtonText: "OK",
        ).choosePlatformToShowDialog(context);
        return null;
      }
    }
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signInWithYandex() {
    // TODO: implement signInWithYandex
    throw UnimplementedError();
  }

  @override
  Future<bool> signOut(BuildContext context, VKLogin vkPlugin) async {
    try {
      // final _facebookLogin = FacebookLogin();
      // await _facebookLogin.logOut();

      // final _googleSignIn = GoogleSignIn();
      // await _googleSignIn.signOut();

      // await _firebaseAuth.signOut();
      await vkPlugin.logOut();

      return true;
    } catch (e) {
      print("Sign out error Auth Service:" + e.toString());
      await PlatformAlertDialog(
        subject: "Ошибка при выходе",
        content: "Ошибка: ${e.toString()}",
        mainButtonText: "OK",
      ).choosePlatformToShowDialog(context);
      return false;
    }
  }
}
