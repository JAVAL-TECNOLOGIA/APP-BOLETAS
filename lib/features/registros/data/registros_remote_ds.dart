import 'package:flutter/cupertino.dart';

import '../../../core/network/dio_client.dart';
import '../../../core/network/api_endpoints.dart';

class RegistrosRemoteDS {
  final DioClient _client;
  RegistrosRemoteDS(this._client);

 /* Future<int> upsertRegistro(Map<String, dynamic> payload) async {
    print('hola upsertRegistro');
    final Response res = await _client.dio.post(
      ApiEndpoints.registrosSync, // define esto en api_endpoints.dart
      data: payload,
    );

    // Ajusta según tu backend real:
    // ejemplo: { "serverId": 123 }
    return (res.data['serverId'] as num).toInt();
  }*/

  Future<int> upsertRegistro(Map<String, dynamic> payload) async {
    final res = await _client.dio.post(ApiEndpoints.registrosSync, data: payload);

    debugPrint("OK ${res.statusCode} ${res.data}");

    final data = res.data;
    if (data is! Map) {
      throw Exception('Respuesta inválida del servidor: $data');
    }

    final raw = data['serverRegistroId'];

    if (raw == null) {
      throw Exception('Respuesta sin serverRegistroId: $data');
    }

    if (raw is int) return raw;
    if (raw is num) return raw.toInt();
    if (raw is String) return int.parse(raw);

    throw Exception('serverRegistroId inválido: $raw (${raw.runtimeType})');
  }


}
