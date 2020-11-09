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

class Token {
  final String access;
  final String type;
  final num expiresIn;

  Token(this.access, this.type, this.expiresIn);

  Token.fromMap(Map<String, dynamic> json)
      : access = json['access_token'],
        type = json['token_type'],
        expiresIn = json['expires_in'];
}

class Cover {
  final String id;
  final int offsetY;
  final String source;

  Cover(this.id, this.offsetY, this.source);

  Cover.fromMap(Map<String, dynamic> json)
      : id = json['id'],
        offsetY = json['offset_y'],
        source = json['source'];
}

class FacebookProfile {
  final Cover cover;
  final String name;
  final String firstName;
  final String lastName;
  final String email;
  final String id;

  FacebookProfile.fromMap(Map<String, dynamic> json)
      : cover = json.containsKey('cover') ? Cover.fromMap(json['cover']) : null,
        name = json['name'],
        firstName = json['first_name'],
        lastName = json['last_name'],
        email = json['email'],
        id = json['id'];
}
