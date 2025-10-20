import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app_export.dart';

class ProfileImageSection extends StatelessWidget {
  const ProfileImageSection({
    super.key,
    required this.selectedImage,
    required this.profileImage,
  });

  final String profileImage;
  final ValueNotifier<String?> selectedImage;

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        selectedImage.value = image.path;
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final image = profileImage.isNotEmpty ? profileImage : AppConfig.defaultProfile;
    return ValueListenableBuilder(
      valueListenable: selectedImage,
      builder: (_, file, _) {
        return GestureDetector(
          onTap: () {
            pickImage();
          },
          child: Stack(
            children: [
              Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 4),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: showImage(
                      image: image,
                      file: file != null ? File(file) : null,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 5,
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                  child: const Icon(Icons.camera_alt_outlined),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ImageProvider<Object> showImage({
    required File? file,
    required String image,
  }) {
    if (file != null) {
      return FileImage(file);
    } else {
      return CachedNetworkImageProvider(image);
    }
  }
}
