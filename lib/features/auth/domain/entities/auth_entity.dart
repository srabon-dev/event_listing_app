class AuthEntity {
  final String userId;
  final String rvId;
  final String chassisId;
  final String accessToken;
  final String refreshToken;

  const AuthEntity({
    required this.userId,
    required this.rvId,
    required this.chassisId,
    required this.accessToken,
    required this.refreshToken,
  });

  bool get isRvIdAvailable => rvId.isNotEmpty;
  bool get isChassisIdAvailable => chassisId.isNotEmpty;
}