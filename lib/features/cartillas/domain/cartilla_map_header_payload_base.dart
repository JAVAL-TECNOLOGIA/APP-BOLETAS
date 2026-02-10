import 'cartilla_payload_accessors.dart';

abstract class CartillaMapHeaderPayloadBase<TPayload extends CartillaMapHeaderPayloadBase<TPayload>>
    implements CartillaPayloadAccessors {
  final Map<String, dynamic> header;
  final Map<String, dynamic> body;

  const CartillaMapHeaderPayloadBase({
    required this.header,
    required this.body,
  });

  TPayload copyWith({
    Map<String, dynamic>? header,
    Map<String, dynamic>? body,
  });

  @override
  dynamic getHeaderValue(String key) => header[key];

  @override
  TPayload setHeaderValue(String key, dynamic value) {
    final next = Map<String, dynamic>.from(header);
    next[key] = value;
    return copyWith(header: next);
  }

  @override
  dynamic getBodyValue(String key) => body[key];

  @override
  TPayload setBodyValue(String key, dynamic value) {
    final next = Map<String, dynamic>.from(body);
    next[key] = value;
    return copyWith(body: next);
  }

  @override
  int getBodyInt(String key, {int fallback = 0}) {
    final v = body[key];
    if (v == null) return fallback;
    if (v is int) return v;
    if (v is num) return v.toInt();
    if (v is String) return int.tryParse(v) ?? fallback;
    return fallback;
  }
}
