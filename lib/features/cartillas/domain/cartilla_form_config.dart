import 'cartilla_form_models.dart';

abstract class CartillaFormConfig {
  String get templateKey;
  int get payloadVersion;

  List<CartillaSectionConfig> get sections;

  /// Keys que pertenecen al header (para saber si se guarda en header o body)
  Set<String> get headerKeys;

  /// Opciones estáticas (si aplica)
  List<String> get etapaFenologicaOptions;

  /// (+1) qué copiar en header (keys del header)
  Set<String> get plusOneReplicableHeaderKeys;

  Set<String> get plusOneReplicableBodyKeys;
}
