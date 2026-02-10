class CartillaHeaderV1 {
  final int plantillaId;
  final int userId;
  final String? campaniaId;
  final int? loteId;
  final double? lat;
  final double? lon;
  final DateTime? fechaEjecucion;

  const CartillaHeaderV1({
    required this.plantillaId,
    required this.userId,
    this.campaniaId,
    this.loteId,
    this.lat,
    this.lon,
    this.fechaEjecucion,
  });

  Map<String, dynamic> toMap() => {
    'plantillaId': plantillaId,
    'userId': userId,
    'campaniaId': campaniaId,
    'loteId': loteId,
    'lat': lat,
    'lon': lon,
    'fechaEjecucion': fechaEjecucion?.toIso8601String(),
  };

  factory CartillaHeaderV1.fromMap(Map<String, dynamic> map) {
    double? d(v) => v == null ? null : (v as num).toDouble();
    DateTime? dt(v) => v is String ? DateTime.tryParse(v) : null;

    return CartillaHeaderV1(
      plantillaId: (map['plantillaId'] as num).toInt(),
      userId: (map['userId'] as num).toInt(),
      campaniaId: map['campaniaId'],
      loteId: (map['loteId'] as num?)?.toInt(),
      lat: d(map['lat']),
      lon: d(map['lon']),
      fechaEjecucion: dt(map['fechaEjecucion']),
    );
  }
}
