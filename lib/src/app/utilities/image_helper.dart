import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageHelper {
  final picker = ImagePicker();

  /// Pick image, copy to app storage, and return saved path
  Future<String?> pickAndSaveImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source, imageQuality: 80);
    if (pickedFile == null) return null;
    final appDir = await getApplicationDocumentsDirectory();
    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${pickedFile.name}';
    final savedPath = '${appDir.path}/$fileName';
    final savedFile = await File(pickedFile.path).copy(savedPath);
    return savedFile.path;
  }

  /// Delete the image file from app storage if it exists
  Future<void> deleteImage(String? path) async {
    if (path == null || path.isEmpty) return;
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
 