import 'package:event_listing_app/app_export.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../widgets/event_add_page_four.dart';
import '../widgets/event_add_page_one.dart';
import '../widgets/event_add_page_three.dart';
import '../widgets/event_add_page_two.dart';

class EventAddScreen extends StatefulWidget {
  const EventAddScreen({super.key});

  @override
  State<EventAddScreen> createState() => _EventAddScreenState();
}

class _EventAddScreenState extends State<EventAddScreen> {
  final PageController pageController = PageController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //Page One
  final TextEditingController eventName = TextEditingController();
  final TextEditingController eventDescription = TextEditingController();
  final TextEditingController eventPhoneNumber = TextEditingController();

  final ValueNotifier<String?> selectedImage = ValueNotifier(null);
  final ValueNotifier<String?> selectedSportType = ValueNotifier(null);
  final ValueNotifier<String?> selectedEventType = ValueNotifier(null);

  // Page Two
  final ValueNotifier<DateTime?> registrationDate = ValueNotifier(null);
  final ValueNotifier<DateTime?> registrationEndDate = ValueNotifier(null);

  final ValueNotifier<DateTime?> eventStartDate = ValueNotifier(null);
  final ValueNotifier<DateTime?> eventEndDate = ValueNotifier(null);

  // page Three
  final ValueNotifier<String?> selectedAgesGroup = ValueNotifier(null);
  final ValueNotifier<String?> selectedSkillLevel = ValueNotifier(null);
  final ValueNotifier<PickedLocation?> location = ValueNotifier(null);
  final TextEditingController availableSlot = TextEditingController();
  final TextEditingController zipCode = TextEditingController();
  final TextEditingController city = TextEditingController();

  //Page Four
  final TextEditingController link = TextEditingController();
  final TextEditingController eventFee = TextEditingController();
  final QuillController quillController = QuillController.basic();

  @override
  void dispose() {
    pageController.dispose();

    eventName.dispose();
    eventDescription.dispose();
    eventPhoneNumber.dispose();

    selectedImage.dispose();
    selectedSportType.dispose();
    selectedEventType.dispose();

    registrationDate.dispose();
    registrationEndDate.dispose();

    eventStartDate.dispose();
    eventEndDate.dispose();

    selectedAgesGroup.dispose();
    selectedSkillLevel.dispose();
    availableSlot.dispose();
    zipCode.dispose();
    location.dispose();
    city.dispose();

    link.dispose();
    eventFee.dispose();
    quillController.dispose();

    super.dispose();
  }

  void clear() {
    eventName.clear();
    eventDescription.clear();
    eventPhoneNumber.clear();
    selectedImage.value = null;
    selectedSportType.value = null;
    selectedEventType.value = null;

    registrationDate.value = null;
    registrationEndDate.value = null;
    eventStartDate.value = null;
    eventEndDate.value = null;

    selectedAgesGroup.value = null;
    selectedSkillLevel.value = null;
    availableSlot.clear();
    zipCode.clear();
    location.value = null;
    city.clear();

    link.clear();
    eventFee.clear();
    quillController.clear();

    pageController.jumpToPage(0);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.add_event),
        titleTextStyle: context.titleMedium,
      ),
      body: Form(
        key: formKey,
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            EventAddPageOne(
              pageController: pageController,
              formKey: formKey,

              selectedImage: selectedImage,
              selectedSportType: selectedSportType,
              selectedEventType: selectedEventType,

              eventName: eventName,
              eventDescription: eventDescription,
              eventPhoneNumber: eventPhoneNumber,
            ),
            EventAddPageTwo(
              pageController: pageController,
              formKey: formKey,

              registrationDate: registrationDate,
              registrationEndDate: registrationEndDate,

              eventStartDate: eventStartDate,
              eventEndDate: eventEndDate,
            ),
            EventAddPageThree(
              pageController: pageController,
              formKey: formKey,
              selectedAgesGroup: selectedAgesGroup,
              selectedSkillLevel: selectedSkillLevel,
              availableSlot: availableSlot,
              zipCode: zipCode,
              location: location,
              city: city,
            ),
            EventAddPageFour(
              pageController: pageController,
              formKey: formKey,
              link: link,
              eventFee: eventFee,
              quillController: quillController,
              onComplete: () {
                clear();
                context.read<ManagementHomeCubit>().pagingController.refresh();
                context.read<MyEventCubit>().pagingController.refresh();
              },
              onTap: (){
                if (formKey.currentState!.validate()) {
                  final selected = selectedAgesGroup.value ?? "Any Age";

                  int minAge = 0;
                  int maxAge = 1000;

                  if (selected == "Any Age") {
                    minAge = 0;
                    maxAge = 1000;
                  } else if (selected.contains("–")) {
                    final parts = selected.split("–");
                    minAge = int.tryParse(parts.first.trim()) ?? 0;
                    maxAge = int.tryParse(parts.last.replaceAll(RegExp(r'[^0-9]'), '').trim()) ?? 1000;
                  } else if (selected.contains("+")) {
                    minAge = int.tryParse(selected.replaceAll(RegExp(r'[^0-9]'), '').trim()) ?? 0;
                    maxAge = 1000;
                  }

                  final entities = EventAddEntities(
                    name: eventName.text,
                    shortDescription: eventDescription.text,
                    sport: selectedSportType.value ?? "",
                    eventType: selectedEventType.value ?? "",
                    registrationStartDate: registrationDate.value!,
                    registrationEndDateTime: registrationEndDate.value!,
                    eventStartDateTime: eventStartDate.value!,
                    eventEndDateTime: eventEndDate.value!,
                    minAge: minAge,
                    maxAge: maxAge,
                    skillLevel: selectedSkillLevel.value ?? "",
                    availableSlot: int.tryParse(availableSlot.text.trim()) ?? 0,
                    zipCode: zipCode.text.trim(),
                    address: location.value?.address ?? "",
                    latitude: location.value?.latitude ?? 0.0,
                    longitude: location.value?.longitude ?? 0.0,
                    city: city.text,
                    websiteLink: link.text.trim(),
                    registrationFee: double.tryParse(eventFee.text.trim()) ?? 0.0,
                    description: quillController.document.toPlainText().trim(),
                  );

                  final List<String> imagePath = selectedImage.value != null ? [selectedImage.value!] : [];



                  context.read<EventAddBloc>().add(
                    EventAdd(
                      entities: entities,
                      imagePath: imagePath,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
