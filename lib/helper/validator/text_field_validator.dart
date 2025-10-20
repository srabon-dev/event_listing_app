import 'package:event_listing_app/app_export.dart';

class TextFieldValidator {

  static String? Function(String?) email(BuildContext context) {
    return (value) {
      final trimmed = value?.trim() ?? '';
      if (trimmed.isEmpty) {
        return context.loc.emailIsRequired;
      }
      final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      if (!emailRegex.hasMatch(trimmed)) {
        return context.loc.enterAValidEmail;
      }
      return null;
    };
  }

  static String? Function(String?) password(BuildContext context) {
    return (value) {
      final trimmed = value?.trim() ?? '';
      if (trimmed.isEmpty) {
        return context.loc.passwordIsRequired;
      }
      if (trimmed.length < 6) {
        return context.loc.passwordMustBeAtLeastCharacters;
      }
      return null;
    };
  }

  static String? Function(String?) confirmPassword(
      BuildContext context,
      TextEditingController originalController,
      ) {
    return (value) {
      final trimmed = value?.trim() ?? '';
      if (trimmed.isEmpty) {
        return context.loc.confirmPasswordIsRequired;
      }
      if (trimmed != originalController.text.trim()) {
        return context.loc.passwordsDoNotMatch;
      }
      return null;
    };
  }

  static String? Function(String?) otp(BuildContext context) {
    return (value) {
      final trimmed = value?.trim() ?? '';
      if (trimmed.isEmpty) {
        return context.loc.otpIsRequired;
      }
      if (trimmed.length != 6) {
        return context.loc.otpMustBe6Digits;
      }
      return null;
    };
  }

  static String? Function(String?) required(BuildContext context) {
    return (value) {
      final trimmed = value?.trim() ?? '';
      if (trimmed.isEmpty) {
        return context.loc.fieldIsRequired;
      }
      return null;
    };
  }

  static String? Function(String?) name(BuildContext context) {
    return (value) {
      final trimmed = value?.trim() ?? '';
      if (trimmed.isEmpty) {
        return context.loc.nameIsRequired;
      }
      final nameRegex = RegExp(r"^[a-zA-Z\s]{2,}$");
      if (!nameRegex.hasMatch(trimmed)) {
        return context.loc.nameIsRequired;
      }
      return null;
    };
  }
}
