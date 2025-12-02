import 'package:event_listing_app/app_export.dart';
import 'package:event_listing_app/features/management/event_add/presentation/widgets/event_add_page_four.dart';
import 'package:event_listing_app/features/management/event_add/presentation/widgets/event_add_page_one.dart';
import 'package:event_listing_app/features/management/event_add/presentation/widgets/event_add_page_three.dart';
import 'package:event_listing_app/features/management/event_add/presentation/widgets/event_add_page_two.dart';
import 'package:flutter_quill/flutter_quill.dart';


class EventEditScreen extends StatelessWidget {
  const EventEditScreen({super.key, required this.eventDetailsEntity});
  final EventDetailsEntity eventDetailsEntity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EventEditBloc(
        db: sl<ILocalService>(),
        repository: EventEditRepository(apiClient: sl<IApiClient>()),
      ),
      child: _View(eventDetailsEntity: eventDetailsEntity,),
    );
  }
}

class _View extends StatefulWidget {
  const _View({required this.eventDetailsEntity});
  final EventDetailsEntity eventDetailsEntity;

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  final PageController pageController = PageController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //Page One
  TextEditingController eventName = TextEditingController();
  TextEditingController eventDescription = TextEditingController();

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
  TextEditingController availableSlot = TextEditingController();
  TextEditingController zipCode = TextEditingController();
  TextEditingController city = TextEditingController();

  //Page Four
  TextEditingController link = TextEditingController();
  TextEditingController eventFee = TextEditingController();
  final QuillController quillController = QuillController.basic();

  @override
  void initState() {
    final e = widget.eventDetailsEntity;

    eventName = TextEditingController(text: e.name);
    eventDescription = TextEditingController(text: e.description);
    selectedSportType.value = e.sport?.id;
    selectedEventType.value = e.eventType?.id;

    registrationDate.value = e.registrationStartDate;
    registrationEndDate.value = e.registrationEndDateTime;
    eventStartDate.value = e.eventStartDateTime;
    eventEndDate.value = e.eventEndDateTime;

    selectedAgesGroup.value = mapAgeGroup(e.minAge, e.maxAge);
    selectedSkillLevel.value = mapSkillLevel(e.skillLevel);
    location.value = mapLocation(e.location, e.address);
    availableSlot = TextEditingController(
      text: e.availableSlot?.toString() ?? "",
    );

    zipCode = TextEditingController(text: e.zipCode ?? "");
    city = TextEditingController(text: e.city ?? "");

    link = TextEditingController(text: e.websiteLink ?? "");
    eventFee = TextEditingController(
      text: e.registrationFee?.toString() ?? "",
    );

    final plainDescription = e.description ?? "";
    quillController.document = Document()..insert(0, plainDescription);

    super.initState();
  }

  String mapAgeGroup(num? minAge, num? maxAge) {
    if (minAge == null || maxAge == null) return "Any Age";

    if (minAge == 0 && maxAge >= 100) return "Any Age";

    if (maxAge >= 100) return "$minAge+ years";

    return "$minAge–$maxAge years";
  }

  String? mapSkillLevel(String? level) {
    const levels = ["Intermediate", "Beginner", "Advanced"];
    if (level == null) return null;

    if (levels.contains(level)) return level;

    return null;
  }

  PickedLocation? mapLocation(EventDetailsLocationEntity? loc, String? address) {
    if (loc?.coordinates == null || loc!.coordinates!.length != 2) return null;

    final lng = loc.coordinates![0];
    final lat = loc.coordinates![1];

    if (!lat.isFinite || lat == 0) return null;
    if (!lng.isFinite || lng == 0) return null;

    return PickedLocation(
      latitude: lat,
      longitude: lng,
      address: address ?? "",
    );
  }



  @override
  void dispose() {
    pageController.dispose();

    eventName.dispose();
    eventDescription.dispose();

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
        title: Text(context.loc.edit_event),
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
              netWorkImage: widget.eventDetailsEntity.image,

              selectedImage: selectedImage,
              selectedSportType: selectedSportType,
              selectedEventType: selectedEventType,

              eventName: eventName,
              eventDescription: eventDescription,
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
              actionWidget: Row(
                spacing: 24,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final currentPage = pageController.page?.round() ?? 0;
                        if (currentPage > 0) {
                          pageController.previousPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          AppLogger.log("Already on the first page");
                        }
                      },
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(AppColors.white),
                        foregroundColor: WidgetStatePropertyAll(AppColors.brandHoverColor),
                        side: WidgetStatePropertyAll(
                          BorderSide(color: AppColors.brandHoverColor, width: 1.5),
                        ),
                      ),
                      child: Text(context.loc.previous),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final plainText = quillController.document.toPlainText().trim();
                          if (plainText.isEmpty) {
                            AppToast.warning(message: context.loc.pleaseDescribeYourEvent);
                            return;
                          }

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



                          context.read<EventEditBloc>().add(
                            EventEditNewEvent(
                              entities: entities,
                              id: widget.eventDetailsEntity.id,
                              imagePath: imagePath,
                            ),
                          );
                        }
                      },
                      child: BlocConsumer<EventEditBloc, EventEditState>(
                        listener: (context, state) {
                          if (state is EventEditNewState) {
                            if (state.message != null) {
                              AppToast.info(context: context, message: state.message ?? "");
                            }
                            if (state.isVerified) {
                              clear();
                              context.read<ManagementHomeCubit>().pagingController.refresh();
                              context.read<MyEventCubit>().pagingController.refresh();
                              if(Navigator.canPop(context)){
                                AppRouter.route.pop(true);
                              }
                            }
                          }
                        },
                        builder: (context, state) {
                          final data = state is EventEditNewState && state.isLoading;
                          if(data) {
                            return const LoadingWidget(color: AppColors.white,);
                          }
                          return Text(context.loc.savePublish);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
