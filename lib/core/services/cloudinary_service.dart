import 'dart:io';

import 'package:cloudinary_api/src/request/model/uploader_params.dart';
import 'package:cloudinary_api/uploader/cloudinary_uploader.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';

class CloudinaryService {
  CloudinaryService._();

  static final CloudinaryService instance = CloudinaryService._();

  static const String _cloudName = "v3azkduu";
  static const String _uploadPreset = "chat_app_preset";

  final Cloudinary _cloudinary = Cloudinary.fromCloudName(cloudName: _cloudName);

  Future<String?> uploadImageCustomPath({required String localPath, required String uploadFolderPath}) async {
    print('cloudinary function called');

    try {
      final response = await _cloudinary.uploader().upload(
        File(localPath),
        params: UploadParams(unsigned: true, uploadPreset: _uploadPreset, folder: uploadFolderPath),
      );

      print(response?.error?.message);

      return response?.data?.secureUrl;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
