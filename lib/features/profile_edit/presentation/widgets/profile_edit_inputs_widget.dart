import '../../../../app_export.dart';
import 'profile_image_section.dart';

class ProfileEditInputsWidget extends StatelessWidget {
  const ProfileEditInputsWidget({
    super.key,
    required this.name,
    required this.phone,
    required this.location,
    required this.selectedImage,
    required this.profileImage,
  });

  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController location;
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
          title: context.loc.name,
          hintText: context.loc.pleaseEnterYourName,
          keyboardType: TextInputType.name,
          controller: name,
          validator: TextFieldValidator.name(context),
        ),
        CustomTextField(
          title: context.loc.phone_number,
          hintText: context.loc.phone_number,
          keyboardType: TextInputType.phone,
          controller: phone,
          validator: TextFieldValidator.required(context),
        ),
        CustomTextField(
          title: context.loc.location,
          hintText: context.loc.location,
          keyboardType: TextInputType.text,
          controller: location,
          validator: TextFieldValidator.required(context),
        ),
      ],
    );
  }
}
