import '../../../core/network/dio_client.dart';

class MasterRemoteDs {
  final DioClient _client;
  MasterRemoteDs(this._client);

  Future<Map<String, dynamic>> fetchBootstrap() async {
    // ✅ usa la instancia Dio real
    final r = await _client.dio.get('/api/bootstrap');

    if (r.data is Map<String, dynamic>) return r.data as Map<String, dynamic>;
    return (r.data as Map).cast<String, dynamic>();
  }
}
