import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PhotoCaptureResult {
  final int slot;
  final String localPath;
  final DateTime createdAt;

  PhotoCaptureResult({
    required this.slot,
    required this.localPath,
    required this.createdAt,
  });
}

class PhotoService {
  final ImagePicker _picker;

  PhotoService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  /// Captura una foto con cámara y la mueve/copia a una carpeta estable
  /// dentro de documentos: /cartillas/{localId}/foto_{slot}.jpg
  Future<PhotoCaptureResult?> captureToSlot({
    required int localId,
    required int slot,
    int imageQuality = 85,
  }) async {
    final cam = await Permission.camera.request();
    debugPrint('CAM PERMISSION => $cam');
    if (!cam.isGranted) return null;

    final XFile? shot = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: imageQuality,
    );
    debugPrint('SHOT => ${shot?.path}');

    if (shot == null) return null;

    final dir = await getApplicationDocumentsDirectory();
    final folder = Directory('${dir.path}/cartillas/$localId');
    await folder.create(recursive: true);

    final targetPath = '${folder.path}/foto_$slot.jpg';

    // Reemplaza si ya existía
    final targetFile = File(targetPath);
    if (await targetFile.exists()) {
      await targetFile.delete();
    }

    await File(shot.path).copy(targetPath);

    return PhotoCaptureResult(
      slot: slot,
      localPath: targetPath,
      createdAt: DateTime.now().toUtc(),
    );
  }

  Future<void> deleteSlot({
    required int localId,
    required int slot,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/cartillas/$localId/foto_$slot.jpg';
    final f = File(path);
    if (await f.exists()) await f.delete();
  }

  Future<bool> existsSlot({
    required int localId,
    required int slot,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/cartillas/$localId/foto_$slot.jpg').exists();
  }

  Future<String> slotPath({
    required int localId,
    required int slot,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/cartillas/$localId/foto_$slot.jpg';
  }
}
