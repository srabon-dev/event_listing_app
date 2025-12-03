import 'package:event_listing_app/app_export.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;
import 'package:image_picker/image_picker.dart';
import 'package:map_location_picker/map_location_picker.dart';

Future<String?> pickImage() async {
  try {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image?.path;
  } catch (_) {
    return null;
  }
}

String getAgeRangeLabel(num minAge, num maxAge) {
  print("$maxAge - $minAge");
  if (minAge == 0 && maxAge == 1000) {
    return "Any Age";
  } else if (minAge == 5 && maxAge == 7) {
    return "5–7 years";
  } else if (minAge == 8 && maxAge == 10) {
    return "8–10 years";
  } else if (minAge == 11 && maxAge == 13) {
    return "11–13 years";
  } else if (minAge == 14 && maxAge == 16) {
    return "14–16 years";
  } else if (minAge == 17 && (maxAge == 100000 || maxAge == 1000)) {
    return "17+ years";
  } else {
    return "$minAge–$maxAge years";
  }
}

String formatRating(num rating, {num maxRating = 5.0}) {
  return '${rating.toStringAsFixed(1)} / ${maxRating.toStringAsFixed(1)}';
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

Future<PickedLocation?> openLocationPicker(BuildContext context) async {
  try {
    final result = await Navigator.push<GeocodingResult?>(
      context,
      MaterialPageRoute(
        builder: (context) => MapLocationPicker(
          config: MapLocationPickerConfig(
            apiKey: "AIzaSyC_qKHmzl-HHB9hr8-fWGmhETSVR2H0894",
            initialPosition: const LatLng(23.7104, 90.4074),
            onNext: (picked) {
              Navigator.of(context).pop(picked);
            },
          ),
          geoCodingConfig: GeoCodingConfig(apiKey: "AIzaSyC_qKHmzl-HHB9hr8-fWGmhETSVR2H0894"),
          searchConfig: const SearchConfig(apiKey: "AIzaSyC_qKHmzl-HHB9hr8-fWGmhETSVR2H0894"),
        ),
      ),
    );

    if (result != null && result.geometry?.location.lat != null && result.geometry?.location.lng != null) {
      final lat = result.geometry!.location.lat;
      final lng = result.geometry!.location.lng;
      final address = result.formattedAddress ?? "";

      return PickedLocation(latitude: lat, longitude: lng, address: address);
    }
    return null;
  } catch (e) {
    AppLogger.log("Error opening location picker: ${e.toString()}");
    if (context.mounted) {
      AppToast.error(context: context, message: "Failed to pick location. Please try again.");
    }
    return null;
  }
}