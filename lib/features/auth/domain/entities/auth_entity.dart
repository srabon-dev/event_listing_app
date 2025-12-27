class AuthEntity {
  final String userId;
  final String role;
  final String accessToken;
  final String refreshToken;
  final bool hasActiveSubscription;

  const AuthEntity({
    required this.userId,
    required this.role,
    required this.accessToken,
    required this.refreshToken,
    required this.hasActiveSubscription,
  });

  bool get hasAccessToken => accessToken.isNotEmpty;
  bool get hasRefreshToken => refreshToken.isNotEmpty;
  bool get hasUserId => userId.isNotEmpty;
  bool get hasRole => role.isNotEmpty;

  bool get isUser => role.toLowerCase() == 'user';
  bool get isOrganizer => role.toLowerCase() == 'organizer';

  bool get isSuccess => hasAccessToken && hasRefreshToken && hasUserId && hasRole;
}