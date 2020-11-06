import 'package:flutter/material.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';

class UserModel extends ChangeNotifier {
  String userID;
  String accesToken;
  String email;
  String username;
  String firstName;
  String lastName;
  String profileURL;
  DateTime createdAt;
  DateTime updatedAt;

  UserModel({
    this.userID,
    this.accesToken,
    this.email,
    this.createdAt,
    this.profileURL,
    this.updatedAt,
    this.username,
    this.firstName,
    this.lastName,
  });

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'accesToken': accesToken,
      'email': email,
      'username': username,
      'profileURL': profileURL ?? 'https://via.placeholder.com/150',
      'createdAt': createdAt ?? DateTime.now(),
      'updatedAt': updatedAt ?? DateTime.now(),
    };
  }

  UserModel.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        accesToken = map['accesToken'],
        email = map['email'],
        username = map['username'],
        profileURL = map['profileURL'],
        createdAt = map['createdAt'],
        updatedAt = map['updatedAt'];

  void updateUserModelWithVK(
    VKAccessToken accessToken,
    VKUserProfile vkUserProfile,
  ) {
    this.accesToken = accesToken.toString();
    this.firstName = vkUserProfile.firstName.toString() ?? '';
    this.lastName = vkUserProfile.lastName.toString() ?? '';
    this.profileURL =
        vkUserProfile.photo200.toString() ?? vkUserProfile.photo100.toString();
    this.userID = vkUserProfile.userId.toString();
    this.username = vkUserProfile.firstName.toString().toLowerCase();

    notifyListeners();
  }
}
