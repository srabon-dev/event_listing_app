import 'package:event_listing_app/app_export.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;
import 'package:image_picker/image_picker.dart';

Future<String?> pickImage() async {
  try {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image?.path;
  } catch (_) {
    return null;
  }
}

Future<DateTime?> pickDateTime({required BuildContext context, DateTime? minTime}) async {
  DateTime? selectedDateTime;

  try {
    DateTime now = DateTime.now().add(const Duration(hours: 1));
    DateTime minimumAllowedTime = minTime != null && minTime.isAfter(now) ? minTime : now;

    await picker.DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      currentTime: minimumAllowedTime,
      minTime: minimumAllowedTime,
      maxTime: DateTime(2100),
      onConfirm: (dateTime) {
        selectedDateTime = dateTime;
      },
      onCancel: () {
        selectedDateTime = null;
      },
      locale: picker.LocaleType.en,
    );
    return selectedDateTime;
  } catch (e) {
    return selectedDateTime;
  }
}
