import 'package:event_listing_app/app_export.dart';

class ProfileModel {
  final bool? success;
  final String? message;
  final ProfileData? data;

  ProfileModel({
    this.success,
    this.message,
    this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };

  ProfileEntity toEntity() {
    final d = data;

    return ProfileEntity(
      id: d?.id ?? '',
      name: d?.name ?? '',
      businessName: d?.businessName ?? '',
      email: d?.email ?? '',
      phone: d?.phone ?? '',
      address: d?.address ?? "",
      profileImage: d?.profileImage ?? '',
    );
  }
}

class ProfileData {
  final String? id;
  final String? businessName;
  final ProfileUser? user;
  final String? name;
  final String? phone;
  final String? email;
  final String? profileImage;
  final String? address;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  ProfileData({
    this.id,
    this.businessName,
    this.user,
    this.name,
    this.phone,
    this.email,
    this.profileImage,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
    id: json["_id"],
    businessName: json["businessName"],
    user: json["user"] == null ? null : ProfileUser.fromJson(json["user"]),
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    profileImage: json["profile_image"],
    address: json["address"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "businessName": businessName,
    "user": user?.toJson(),
    "name": name,
    "phone": phone,
    "email": email,
    "profile_image": profileImage,
    "address": address,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class ProfileUser {
  final String? id;
  final String? profileId;
  final String? email;
  final String? password;
  final String? role;
  final bool? isBlocked;
  final bool? isActive;
  final int? verifyCode;
  final bool? isVerified;
  final bool? isResetVerified;
  final DateTime? codeExpireIn;
  final bool? isDeleted;
  final List<dynamic>? playerIds;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  ProfileUser({
    this.id,
    this.profileId,
    this.email,
    this.password,
    this.role,
    this.isBlocked,
    this.isActive,
    this.verifyCode,
    this.isVerified,
    this.isResetVerified,
    this.codeExpireIn,
    this.isDeleted,
    this.playerIds,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ProfileUser.fromJson(Map<String, dynamic> json) => ProfileUser(
    id: json["_id"],
    profileId: json["profileId"],
    email: json["email"],
    password: json["password"],
    role: json["role"],
    isBlocked: json["isBlocked"],
    isActive: json["isActive"],
    verifyCode: json["verifyCode"],
    isVerified: json["isVerified"],
    isResetVerified: json["isResetVerified"],
    codeExpireIn: json["codeExpireIn"] == null ? null : DateTime.parse(json["codeExpireIn"]),
    isDeleted: json["isDeleted"],
    playerIds: json["playerIds"] == null ? [] : List<dynamic>.from(json["playerIds"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "profileId": profileId,
    "email": email,
    "password": password,
    "role": role,
    "isBlocked": isBlocked,
    "isActive": isActive,
    "verifyCode": verifyCode,
    "isVerified": isVerified,
    "isResetVerified": isResetVerified,
    "codeExpireIn": codeExpireIn?.toIso8601String(),
    "isDeleted": isDeleted,
    "playerIds": playerIds == null ? [] : List<dynamic>.from(playerIds!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

