import 'dart:io';

class MultipartBody {
  final String fieldKey;
  final File file;

  MultipartBody({
    required this.fieldKey,
    required this.file,
  });
}
