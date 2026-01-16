import 'package:dio/dio.dart';
import '../../../core/network/api_endpoints.dart';

class AuthRemoteDS {
  final Dio dio;
  AuthRemoteDS(this.dio);

  Future<Map<String, dynamic>> login(String username, String password) async {
    final resp = await dio.post(ApiEndpoints.login, data: {
      'username': username,
      'password': password,
    });
    return Map<String, dynamic>.from(resp.data);
  }
}
