class User {
  final String? nickname;
  final String? email;
  final String? profile;

  User({required this.nickname, required this.email, required this.profile});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        nickname: json['nickname'],
        email: json['email'],
        profile: json['profile']);
  }
  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'email': email,
        'profile': profile,
      };
}
