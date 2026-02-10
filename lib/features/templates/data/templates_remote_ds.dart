import 'package:dio/dio.dart';

class TemplatesRemoteDS {
  TemplatesRemoteDS(this._dio);

  final Dio _dio;

  Future<Map<String, dynamic>> fetchAssigned({String? sinceIso}) async {
    final resp = await _dio.get(
      '/api/plantillas/asignadas/',
      queryParameters: sinceIso == null ? null : {'since': sinceIso},
    );
    return resp.data as Map<String, dynamic>;
  }
}
