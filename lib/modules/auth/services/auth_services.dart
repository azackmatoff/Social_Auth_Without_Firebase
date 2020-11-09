import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:socialauthenthication/modules/auth/constants/api.dart';
import 'package:socialauthenthication/modules/auth/models/insta_token.dart';
import 'package:socialauthenthication/modules/auth/models/user_model.dart';
import 'package:socialauthenthication/modules/auth/services/auth_base.dart';
import 'package:socialauthenthication/modules/auth/services/temporary_server.dart';
import 'package:socialauthenthication/modules/widgets/platform_alert_dialog.dart';
import 'package:simple_auth/simple_auth.dart' as authAPI;
import 'package:http/http.dart' as http;
import 'dart:io';

class AuthServices implements AuthBase {
  final flutterWebviewPlugin = FlutterWebviewPlugin();
  final facebookLogin = FacebookLogin();
  @override
  Future<UserModel> currentUser() {
    // TODO: implement currentUser
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signInWithFacebook(BuildContext context) async {
    FacebookLoginResult _facebookLoginResult =
        await facebookLogin.logIn(['public_profile', 'email']);

    switch (_facebookLoginResult.status) {
      case FacebookLoginStatus.loggedIn:
        if (_facebookLoginResult.accessToken != null &&
            _facebookLoginResult.accessToken.isValid()) {
          final token = _facebookLoginResult.accessToken.token;

          /// to get profile details
          final graphResponse = await http.get(
              'https://graph.facebook.com/v2.12/me?fields=name,picture,first_name,last_name,email&access_token=$token');
          // print("graphResponse " + graphResponse.body.toString());
          final profile = json.decode(graphResponse.body);
          // print("profile.name " + profile['name'].toString());
          // print("profile['picture']['data']['url'].toString() " +
          //     profile['picture']['data']['url'].toString());

          return UserModel(
            accesToken: token,
            username: profile['name'].toString(),
            userID: profile['id'].toString(),
            email: profile['email'].toString(),
            firstName: profile['first_name'].toString(),
            lastName: profile['last_name'].toString(),
            profileURL: profile['picture']['data']['url'].toString(),
          );
        } else {
          return null;
        }
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("User cancelled Facebook login");

        await PlatformAlertDialog(
          subject: "Ошибка",
          content: "Вы отменили вход в Facebook",
          mainButtonText: "OK",
        ).choosePlatformToShowDialog(context);
        break;
      case FacebookLoginStatus.error:
        print(
            "Facebook login error: ${_facebookLoginResult.errorMessage.toString()}");
        await PlatformAlertDialog(
          subject: "Ошибка при выходе",
          content: "Ошибка: ${_facebookLoginResult.errorMessage.toString()}",
          mainButtonText: "OK",
        ).choosePlatformToShowDialog(context);
        break;
      default:
        return null;
    }
  }

  @override
  Future<UserModel> signInWithInstagram(BuildContext context) async {
    final String redirectUrl = "https://localhost:8585";
    // "https://github.com/azackmatoff";
    try {
      Stream<String> onCode = await TempServer().startServer();
      String url =
          "https://api.instagram.com/oauth/authorize?client_id=${APIKEYS.instagramAppID}&redirect_uri=$redirectUrl&scope=user_profile,user_media&response_type=code";
      flutterWebviewPlugin.launch(url);
      final String code = await onCode.first;
      final http.Response response = await http
          .post("https://api.instagram.com/oauth/access_token", body: {
        "client_id": APIKEYS.instagramAppID,
        "redirect_uri": redirectUrl,
        "client_secret": APIKEYS.instagramAppSecretKey,
        "code": code,
        "grant_type": "authorization_code"
      });

      print("response insta " + response.body.toString());

      InstaToken token = InstaToken.fromMap(jsonDecode(response.body));
      print("token " + token.toString());
      flutterWebviewPlugin.close();
      return UserModel(
        accesToken: token.access,
        userID: token.id,
        username: token.username,
        firstName: token.full_name,
        profileURL: token.profile_picture,
      );
    } catch (e) {
      print("Sign in error signInWithInstagram Service:" + e.toString());
      await PlatformAlertDialog(
        subject: "Ошибка при выходе",
        content: "Ошибка: ${e.toString()}",
        mainButtonText: "OK",
      ).choosePlatformToShowDialog(context);
      return null;
    }
  }

  @override
  Future<UserModel> signInWithTelegram(BuildContext context) {
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
      await facebookLogin.logOut();
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
