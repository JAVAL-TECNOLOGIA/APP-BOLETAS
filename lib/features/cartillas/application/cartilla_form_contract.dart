abstract class CartillaFormStateBase {
  bool get loading;
  bool get saving;
  Map<String, dynamic> get dataJson; // { header: {}, body: {}, observaciones? }
  List<String> get errors;
}

abstract class CartillaFormNotifierBase {
  void updateDataJson(Map<String, dynamic> next);
  Future<void> saveLocal();
  Future<void> finalize();
  Future<int> duplicateAsNew();
}
