class ProfileEntity {
  final String id;
  final String name;
  final String email;
  final String role;
  final String profileImage;
  final bool isVerified;
  final List<RvEntity> rvList;
  final RvEntity? selectedRv;

  const ProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.profileImage,
    required this.isVerified,
    required this.rvList,
    this.selectedRv,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'profileImage': profileImage,
      'isVerified': isVerified,
      'rvList': rvList.map((x) => x.toJson()).toList(),
      'selectedRv': selectedRv?.toJson(),
    };
  }
}

class RvEntity {
  final String id;
  final String nickname;
  final String currentMileage;
  final bool isOverdueForMaintenance;

  const RvEntity({
    required this.id,
    required this.nickname,
    required this.currentMileage,
    required this.isOverdueForMaintenance,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nickname': nickname,
      'currentMileage': currentMileage,
      'isOverdueForMaintenance': isOverdueForMaintenance,
    };
  }
}

