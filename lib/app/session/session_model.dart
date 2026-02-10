class Session {
  final int userId;
  final String accessToken;
  final String refreshToken;
  final DateTime offlineExpiresAt;

  const Session({
    required this.userId,
    required this.accessToken,
    required this.refreshToken,
    required this.offlineExpiresAt,
  });

  bool get isOfflineValid => DateTime.now().isBefore(offlineExpiresAt);
}
