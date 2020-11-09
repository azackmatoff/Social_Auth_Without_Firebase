class InstaToken {
  String access;
  String id;
  String username;
  String full_name;
  String profile_picture;

  InstaToken.fromMap(Map json) {
    access = json['access_token'];
    id = json['user']['id'];
    username = json['user']['username'];
    full_name = json['user']['full_name'];
    profile_picture = json['user']['profile_picture'];
  }
}
