/*
import '../../../../app_export.dart';
import 'profile_image_section.dart';

class ProfileEditInputsWidget extends StatelessWidget {
  const ProfileEditInputsWidget({
    super.key,
    required this.name,
    required this.selectedImage,
    required this.profileImage,
  });

  final TextEditingController name;
  final String profileImage;
  final ValueNotifier<String?> selectedImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 24,
      children: [
        ProfileImageSection(
          selectedImage: selectedImage,
          profileImage: profileImage,
        ),
        CustomTextField(
          title: AppLocalizations.of(context)!.name,
          hintText: AppLocalizations.of(context)!.pleaseEnterYourName,
          keyboardType: TextInputType.name,
          controller: name,
          prefixIcon: const Icon(Icons.person_outline),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.of(context)!.nameIsRequired;
            }
            return null;
          },
        ),
      ],
    );
  }
}
*/
