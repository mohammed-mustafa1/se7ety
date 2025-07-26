import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'dart:convert';

class UploadImageService {
  static Future<String> uploadToImageKit(File imageFile) async {
    final apiKey = 'private_AQDYaP1cSXIpjzpkvaHcSq23zfM=';
    final uploadUrl = 'https://upload.imagekit.io/api/v1/files/upload';

    try {
      Dio dio = Dio();

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imageFile.path),
        'fileName': imageFile.path.split('/').last,
      });

      final response = await dio.post(
        uploadUrl,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Basic ${base64Encode(utf8.encode('$apiKey:'))}',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data['url'];
      } else {
        log("Failed to upload: ${response.statusCode}");
      }
    } catch (e) {
      log('Upload error: $e');
    }

    return '';
  }

  static Future<File?> pickImage({required ImageSource source}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}
