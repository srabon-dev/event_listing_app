import 'package:event_listing_app/app_export.dart';

class EventAddPageTwo extends StatelessWidget {
  const EventAddPageTwo({
    super.key,
    required this.pageController,
    required this.formKey,
    required this.registrationDate,
    required this.registrationEndDate,
    required this.eventStartDate,
    required this.eventEndDate,
  });

  final PageController pageController;
  final GlobalKey<FormState> formKey;

  final ValueNotifier<DateTime?> registrationDate;
  final ValueNotifier<DateTime?> registrationEndDate;
  final ValueNotifier<DateTime?> eventStartDate;
  final ValueNotifier<DateTime?> eventEndDate;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Text(
            context.loc.eventDatesRegistration,
            style: context.headlineLarge.copyWith(fontWeight: FontWeight.w500),
          ),
          const Gap(12),
          ValueListenableBuilder(
            valueListenable: registrationDate,
            builder: (context, date, item){
              return _BoxDateTimeCard(
                title: context.loc.registrationStartDate,
                name: date != null? DateConverter.formatDate(dateTime: date) :context.loc.selectDate,
                icon: Icons.calendar_month_outlined,
                onTap: () async {
                  try{
                    final dateTime = await pickDateTime(context: context);
                    if(dateTime != null){
                      registrationDate.value = dateTime;

                      registrationEndDate.value = null;
                      eventStartDate.value = null;
                      eventEndDate.value = null;
                    }
                  }catch(_){

                  }
                },
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: registrationEndDate,
            builder: (context, date, item){
              return _BoxDateTimeCard(
                title: context.loc.registrationEndDate,
                name: date != null? DateConverter.formatDate(dateTime: date) :context.loc.selectDate,
                icon: Icons.calendar_month_outlined,
                onTap: () async {
                  try{
                    if(registrationDate.value == null) return;
                    final dateTime = await pickDateTime(context: context, minTime: registrationDate.value?.add(const Duration(hours: 1)));
                    if (dateTime != null) {
                      if (!dateTime.isAfter(registrationDate.value!)) {
                        return;
                      }
                      registrationEndDate.value = dateTime;
                      eventStartDate.value = null;
                      eventEndDate.value = null;
                    }
                  }catch(_){

                  }
                },
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: registrationEndDate,
            builder: (context, date, item){
              return _BoxDateTimeCard(
                title: context.loc.registrationEndTime,
                name: date != null? DateConverter.formatDate(dateTime: date, format: "hh:mm a") :context.loc.selectDate,
                icon: Icons.access_time_rounded,
                onTap: () async {
                  try{
                    if(registrationDate.value == null) return;
                    final dateTime = await pickDateTime(context: context, minTime: registrationDate.value?.add(const Duration(hours: 1)));
                    if (dateTime != null) {
                      if (!dateTime.isAfter(registrationDate.value!)) {
                        return;
                      }
                      registrationEndDate.value = dateTime;
                      eventStartDate.value = null;
                      eventEndDate.value = null;
                    }
                  }catch(_){

                  }
                },
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: eventStartDate,
            builder: (context, date, item){
              return _BoxDateTimeCard(
                title: context.loc.eventStartDate,
                name: date != null? DateConverter.formatDate(dateTime: date) :context.loc.selectDate,
                icon: Icons.calendar_month_outlined,
                onTap: () async {
                  try{
                    if(registrationEndDate.value == null) return;
                    final dateTime = await pickDateTime(context: context, minTime: registrationEndDate.value?.add(const Duration(hours: 1)));
                    if (dateTime != null) {
                      if (!dateTime.isAfter(registrationEndDate.value!)) {
                        return;
                      }

                      eventStartDate.value = dateTime;
                      eventEndDate.value = null;
                    }
                  }catch(_){

                  }
                },
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: eventStartDate,
            builder: (context, date, item){
              return _BoxDateTimeCard(
                title: context.loc.eventStartTime,
                name: date != null? DateConverter.formatDate(dateTime: date, format: "hh:mm a") :context.loc.selectDate,
                icon: Icons.access_time_rounded,
                onTap: () async {
                  try{
                    if(registrationEndDate.value == null) return;
                    final dateTime = await pickDateTime(context: context, minTime: registrationEndDate.value?.add(const Duration(hours: 1)));
                    if (dateTime != null) {
                      if (!dateTime.isAfter(registrationEndDate.value!)) {
                        return;
                      }

                      eventStartDate.value = dateTime;
                      eventEndDate.value = null;
                    }
                  }catch(_){

                  }
                },
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: eventEndDate,
            builder: (context, date, item){
              return _BoxDateTimeCard(
                title: context.loc.eventEndDate,
                name: date != null? DateConverter.formatDate(dateTime: date) :context.loc.selectDate,
                icon: Icons.calendar_month_outlined,
                onTap: () async {
                  try{
                    if(eventStartDate.value == null) return;
                    final dateTime = await pickDateTime(context: context, minTime: eventStartDate.value?.add(const Duration(hours: 1)));
                    if (dateTime != null) {
                      if (!dateTime.isAfter(eventStartDate.value!)) {
                        return;
                      }
                      eventEndDate.value = dateTime;
                    }
                  }catch(_){

                  }
                },
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: eventEndDate,
            builder: (context, date, item){
              return _BoxDateTimeCard(
                title: context.loc.eventEndTime,
                name: date != null? DateConverter.formatDate(dateTime: date, format: "hh:mm a") :context.loc.selectDate,
                icon: Icons.access_time_rounded,
                onTap: () async {
                  try{
                    if(eventStartDate.value == null) return;
                    final dateTime = await pickDateTime(context: context, minTime: eventStartDate.value?.add(const Duration(hours: 1)));
                    if (dateTime != null) {
                      if (!dateTime.isAfter(eventStartDate.value!)) {
                        return;
                      }
                      eventEndDate.value = dateTime;
                    }
                  }catch(_){

                  }
                },
              );
            },
          ),
          const Gap(12),
          Row(
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

                      if (registrationDate.value == null ||
                          registrationEndDate.value == null ||
                          eventStartDate.value == null ||
                          eventEndDate.value == null) {
                        AppToast.warning(message: context.loc.pleaseSelectAllDates);
                        return;
                      }
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(context.loc.next),
                ),
              ),
            ],
          ),
          const Gap(24),
        ],
      ),
    );
  }

  bool isOrdered(DateTime? a, DateTime? b) {
    if (a == null || b == null) return true;
    return a.isBefore(b);
  }
}

class _BoxDateTimeCard extends StatelessWidget {
  const _BoxDateTimeCard({required this.name, required this.title, required this.icon, this.onTap});

  final String title;
  final String name;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        CustomAlignText(text: title),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.softBrandColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(name), Icon(icon)],
            ),
          ),
        ),
      ],
    );
  }
}
