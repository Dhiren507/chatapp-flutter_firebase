import 'package:image_picker/image_picker.dart';

class ImagePickerUtils {
  static final ImagePicker _picker = ImagePicker();

  static Future<List<XFile>> pickImage({bool isMultiSelect = false}) async {
    List<XFile> selectedImages = [];
    try {
      if (isMultiSelect == true) {
        List<XFile> imagesSelected = await _picker.pickMultiImage(limit: 10);

        if (imagesSelected.isNotEmpty) {
          selectedImages.addAll(imagesSelected);
        }
      } else {
        XFile? imageSelected = await _picker.pickImage(
          source: ImageSource.gallery,
        );

        if (imageSelected != null) {
          selectedImages.add(imageSelected);
        }
      }

      return selectedImages;
    } catch (e) {
      return [];
    }
  }

  static Future<XFile?> captureImage() async {
    XFile? selectedImage;
    try {
      XFile? imageCaptured = await _picker.pickImage(
        source: ImageSource.camera,
      );

      if (imageCaptured != null) {
        selectedImage = imageCaptured;
      }

      return selectedImage;
    } catch (e) {
      return null;
    }
  }
}
