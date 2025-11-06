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
  final String? user;
  final String? name;
  final String? businessName;
  final String? phone;
  final String? email;
  final String? address;
  final String? profileImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final num? v;

  ProfileData({
    this.id,
    this.user,
    this.name,
    this.businessName,
    this.phone,
    this.email,
    this.address,
    this.profileImage,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
    id: json["_id"],
    user: json["user"],
    name: json["name"],
    businessName: json["businessName"],
    phone: json["phone"],
    email: json["email"],
    address: json["address"],
    profileImage: json["profile_image"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "name": name,
    "businessName": businessName,
    "phone": phone,
    "email": email,
    "address": address,
    "profile_image": profileImage,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
