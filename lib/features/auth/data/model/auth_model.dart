import 'package:event_listing_app/app_export.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthModel {
  final bool? success;
  final String? message;
  final Data? data;

  AuthModel({
    this.success,
    this.message,
    this.data,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };

  AuthEntity toEntity() {
    if (data == null || data!.accessToken == null) {
      return const AuthEntity(
        userId: "",
        accessToken: "",
        refreshToken: "",
        role: "",
        hasActiveSubscription: false,
      );
    }

    Map<String, dynamic> decodedToken = JwtDecoder.decode(data?.accessToken ?? "");
    final userId = decodedToken["id"] ?? "";
    final role = decodedToken["role"] ?? "";

    return AuthEntity(
      userId: userId,
      role: role,
      accessToken: data!.accessToken ?? "",
      refreshToken: data!.refreshToken ?? "",
      hasActiveSubscription: false,
    );
  }
}

class Data {
  final String? accessToken;
  final String? refreshToken;

  Data({
    this.accessToken,
    this.refreshToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
  };
}
