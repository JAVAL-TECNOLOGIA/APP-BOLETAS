import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cartilla_form_config.dart';
import '../application/cartilla_form_contract.dart';

class CartillaFormBinding {
  final String templateKey;
  final CartillaFormConfig Function() configBuilder;

  /// Devuelve el state del formulario (watch)
  final CartillaFormStateBase Function(WidgetRef ref, int localId) watchState;

  /// Devuelve el notifier (read)
  final CartillaFormNotifierBase Function(WidgetRef ref, int localId) readNotifier;

  const CartillaFormBinding({
    required this.templateKey,
    required this.configBuilder,
    required this.watchState,
    required this.readNotifier,
  });
}
