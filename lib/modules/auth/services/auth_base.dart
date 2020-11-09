import 'package:flutter/material.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:socialauthenthication/modules/auth/models/user_model.dart';

abstract class AuthBase {
  Future<UserModel> currentUser();
  Future<bool> signOut(BuildContext context, VKLogin vkPlugin);
  Future<UserModel> signInWithYandex();
  Future<UserModel> signInWithFacebook(BuildContext context);
  Future<UserModel> signInWithVK(BuildContext context, VKLogin vkPlugin);
  Future<UserModel> signInWithInstagram(BuildContext context);
  Future<UserModel> signInWithTelegram(BuildContext context);
}
