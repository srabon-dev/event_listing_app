/*
class SignUpModel {
  final bool? success;
  final String? message;
  final String? accessToken;
  final String? refreshToken;
  final User? user;

  SignUpModel({
    this.success,
    this.message,
    this.accessToken,
    this.refreshToken,
    this.user,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
    success: json["success"],
    message: json["message"],
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "accessToken": accessToken,
    "refreshToken": refreshToken,
    "user": user?.toJson(),
  };
}

class User {
  final String? id;
  final String? name;
  final String? email;
  final num? rv;

  User({
    this.id,
    this.name,
    this.email,
    this.rv,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    rv: json["rv"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "rv": rv,
  };
}
*/
