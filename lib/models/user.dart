import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.fullNameAndEmail,
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.msId,
    this.promo,
    this.campus,
    this.avatarFileName,
  });

  String fullNameAndEmail;
  int id;
  String firstName;
  String lastName;
  String username;
  String msId;
  String promo;
  String campus;
  String avatarFileName;

  factory User.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return User(
      fullNameAndEmail: json['full_name_and_email'],
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      username: json['username'],
      msId: json['ms_id'],
      promo: json['promo'],
      campus: json['campus'],
      avatarFileName: json['avatar_file_name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'full_name_and_email': fullNameAndEmail,
    'id': id,
    'first_name': firstName,
    'last_name': lastName,
    'username': username,
    'ms_id': msId,
    'promo': promo,
    'campus': campus,
    'avatar_file_name': avatarFileName,
  };
}
