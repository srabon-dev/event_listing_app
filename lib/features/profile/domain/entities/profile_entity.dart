class ProfileEntity {
  final String id;
  final String name;
  final String businessName;
  final String email;
  final String phone;
  final String address;
  final String profileImage;

  const ProfileEntity({
    required this.id,
    required this.name,
    required this.businessName,
    required this.email,
    required this.phone,
    required this.address,
    required this.profileImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'businessName': businessName,
      'email': email,
      'phone': phone,
      'address': address,
      'profileImage': profileImage,
    };
  }
}

