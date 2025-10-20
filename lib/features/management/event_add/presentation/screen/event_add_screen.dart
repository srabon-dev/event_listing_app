import 'package:event_listing_app/app_export.dart';

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
            ),
            EventAddPageFour(),
          ],
        ),
      ),
    );
  }
}
