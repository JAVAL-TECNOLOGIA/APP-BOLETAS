import 'dart:convert';

int? tryGetUserIdFromJwt(String? jwt) {
  if (jwt == null || jwt.trim().isEmpty) return null;

  final parts = jwt.split('.');
  if (parts.length != 3) return null;

  try {
    final payload = parts[1];
    final normalized = base64Url.normalize(payload);
    final decoded = utf8.decode(base64Url.decode(normalized));
    final map = jsonDecode(decoded) as Map<String, dynamic>;

    // SimpleJWT a veces usa "user_id"
    final v1 = map['user_id'];
    if (v1 is int) return v1;
    if (v1 is String) return int.tryParse(v1);

    // otros JWT usan "sub"
    final v2 = map['sub'];
    if (v2 is int) return v2;
    if (v2 is String) return int.tryParse(v2);

    return null;
  } catch (_) {
    return null;
  }
}
