import 'cartilla_payload_accessors.dart';
import 'cartilla_header_v1.dart';

abstract class CartillaMapPayloadBase<TPayload extends CartillaMapPayloadBase<TPayload>>
    implements CartillaPayloadAccessors {
  final CartillaHeaderV1 header;
  final Map<String, dynamic> body;

  const CartillaMapPayloadBase({
    required this.header,
    required this.body,
  });

  TPayload copyWith({
    CartillaHeaderV1? header,
    Map<String, dynamic>? body,
  });

  Map<String, dynamic> toJson() => {
    'payloadVersion': 1,
    'header': header.toMap(),
    'body': body,
  };

  @override
  dynamic getHeaderValue(String key) => header.toMap()[key];

  @override
  TPayload setHeaderValue(String key, dynamic value) {
    final m = Map<String, dynamic>.from(header.toMap());
    m[key] = value;
    return copyWith(header: CartillaHeaderV1.fromMap(m));
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
