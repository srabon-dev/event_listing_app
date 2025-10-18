import '../../domain/entities/profile_entity.dart';

class ProfileModel {
  final bool? success;
  final String? message;
  final User? user;

  ProfileModel({
    this.success,
    this.message,
    this.user,
  });

  ProfileModel copyWith({
    bool? success,
    String? message,
    User? user,
  }) =>
      ProfileModel(
        success: success ?? this.success,
        message: message ?? this.message,
        user: user ?? this.user,
      );

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    success: json["success"],
    message: json["message"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "user": user?.toJson(),
  };

  ProfileEntity toEntity() {
    final rvList = user?.rvIds
        ?.map((rv) => RvEntity(
      id: rv.id ?? '',
      nickname: rv.nickname ?? '',
      currentMileage: rv.currentMileage ?? "",
      isOverdueForMaintenance: rv.isOverdueForMaintenance ?? false,
    )).toList() ?? [];

    final selectedRv = user?.selectedRvId == null
        ? null
        : RvEntity(
      id: user!.selectedRvId!.id ?? '',
      nickname: user!.selectedRvId!.nickname ?? '',
      currentMileage: user!.selectedRvId!.currentMileage ?? "",
      isOverdueForMaintenance: user!.selectedRvId!.isOverdueForMaintenance ?? false,
    );

    return ProfileEntity(
      id: user?.id ?? '',
      name: user?.name ?? '',
      email: user?.email ?? '',
      role: user?.role ?? '',
      profileImage: user?.profilePic ?? '',
      isVerified: user?.isVerified ?? false,
      rvList: rvList,
      selectedRv: selectedRv,
    );
  }
}

class User {
  final String? id;
  final String? name;
  final String? email;
  final String? role;
  final List<RvId>? rvIds;
  final bool? isVerified;
  final bool? isBlocked;
  final DateTime? passwordResetCodeExpiresAt;
  final RvId? selectedRvId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? profilePic;

  User({
    this.id,
    this.name,
    this.email,
    this.role,
    this.rvIds,
    this.isVerified,
    this.isBlocked,
    this.passwordResetCodeExpiresAt,
    this.selectedRvId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.profilePic,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? role,
    List<RvId>? rvIds,
    bool? isVerified,
    bool? isBlocked,
    DateTime? passwordResetCodeExpiresAt,
    RvId? selectedRvId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    String? profilePic,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        role: role ?? this.role,
        rvIds: rvIds ?? this.rvIds,
        isVerified: isVerified ?? this.isVerified,
        isBlocked: isBlocked ?? this.isBlocked,
        passwordResetCodeExpiresAt: passwordResetCodeExpiresAt ?? this.passwordResetCodeExpiresAt,
        selectedRvId: selectedRvId ?? this.selectedRvId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
        profilePic: profilePic ?? this.profilePic,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    role: json["role"],
    rvIds: json["rvIds"] == null ? [] : List<RvId>.from(json["rvIds"]!.map((x) => RvId.fromJson(x))),
    isVerified: json["isVerified"],
    isBlocked: json["isBlocked"],
    passwordResetCodeExpiresAt: json["passwordResetCodeExpiresAt"] == null ? null : DateTime.parse(json["passwordResetCodeExpiresAt"]),
    selectedRvId: json["selectedRvId"] == null ? null : RvId.fromJson(json["selectedRvId"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    profilePic: json["profilePic"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "role": role,
    "rvIds": rvIds == null ? [] : List<dynamic>.from(rvIds!.map((x) => x.toJson())),
    "isVerified": isVerified,
    "isBlocked": isBlocked,
    "passwordResetCodeExpiresAt": passwordResetCodeExpiresAt?.toIso8601String(),
    "selectedRvId": selectedRvId?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "profilePic": profilePic,
  };
}

class RvId {
  final String? id;
  final String? nickname;
  final String? currentMileage;
  final bool? isOverdueForMaintenance;

  RvId({
    this.id,
    this.nickname,
    this.currentMileage,
    this.isOverdueForMaintenance,
  });

  RvId copyWith({
    String? id,
    String? nickname,
    String? currentMileage,
    bool? isOverdueForMaintenance,
  }) =>
      RvId(
        id: id ?? this.id,
        nickname: nickname ?? this.nickname,
        currentMileage: currentMileage ?? this.currentMileage,
        isOverdueForMaintenance: isOverdueForMaintenance ?? this.isOverdueForMaintenance,
      );

  factory RvId.fromJson(Map<String, dynamic> json) => RvId(
    id: json["_id"],
    nickname: json["nickname"],
    currentMileage: json["currentMileage"].toString(),
    isOverdueForMaintenance: json["isOverdueForMaintenance"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "nickname": nickname,
    "currentMileage": currentMileage.toString(),
    "isOverdueForMaintenance": isOverdueForMaintenance,
  };
}
