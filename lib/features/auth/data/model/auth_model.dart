/*
import 'package:my_rv_app/features/auth/domain/entities/auth_entity.dart';

class AuthModel {
  final bool? success;
  final String? message;
  final String? accessToken;
  final String? refreshToken;
  final User? user;

  AuthModel({
    this.success,
    this.message,
    this.accessToken,
    this.refreshToken,
    this.user,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
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

  AuthEntity toEntity() {
    final rvList = user?.rv ?? [];

    Rv? rv = rvList.firstWhere(
          (r) => (r.id?.isNotEmpty ?? false) && (r.chassisId?.isNotEmpty ?? false),
      orElse: () => Rv(id: null, chassisId: null),
    );

    if (rv.id == null || rv.id!.isEmpty) {
      rv = rvList.firstWhere(
            (r) => (r.id?.isNotEmpty ?? false),
        orElse: () => Rv(id: null, chassisId: null),
      );
    }

    return AuthEntity(
      userId: user?.id ?? '',
      rvId: rv.id ?? '',
      chassisId: rv.chassisId ?? '',
      accessToken: accessToken ?? '',
      refreshToken: refreshToken ?? '',
    );
  }
}

class User {
  final String? id;
  final String? name;
  final String? email;
  final List<Rv>? rv;

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
    rv: json["rv"] == null ? [] : List<Rv>.from(json["rv"]!.map((x) => Rv.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "rv": rv == null ? [] : List<dynamic>.from(rv!.map((x) => x.toJson())),
  };
}

class Rv {
  final String? id;
  final String? chassisId;

  Rv({
    this.id,
    this.chassisId,
  });

  factory Rv.fromJson(Map<String, dynamic> json) => Rv(
    id: json["id"],
    chassisId: json["chassisId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "chassisId": chassisId,
  };
}
*/
