class User {
  int? id;
  String? name;
  String? email;
  String? avatar;
  String? token;

  User({this.id, this.name, this.email, this.avatar, this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['user']['id'],
        name: json['user']['name'],
        email: json['user']['email'],
        avatar: json['user']['avatar'],
        token: json['token']);
  }
}
