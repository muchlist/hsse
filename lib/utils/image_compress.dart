import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

Future<File> compressFile(File file) async {
  final Directory tempDir = await getTemporaryDirectory();
  final String tempPath = tempDir.path;

  final String tempTargetPath = tempPath + file.path.split('/').last;
  final File? result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    tempTargetPath,
    quality: 70,
    minWidth: 960,
    // rotate: 180,
  );
  if (result == null) {
    // gagal di kompress
    return file;
  }
  return result;
}
