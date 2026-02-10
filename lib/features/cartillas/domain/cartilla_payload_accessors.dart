abstract class CartillaPayloadAccessors {
  // Header
  dynamic getHeaderValue(String key);
  CartillaPayloadAccessors setHeaderValue(String key, dynamic value);

  // Body
  dynamic getBodyValue(String key);
  CartillaPayloadAccessors setBodyValue(String key, dynamic value);
  int getBodyInt(String key, {int fallback = 0});
}
