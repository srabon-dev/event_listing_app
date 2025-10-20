import 'package:event_listing_app/app_export.dart';

class EventAddPageThree extends StatelessWidget {
  const EventAddPageThree({
    super.key,
    required this.pageController,
    required this.formKey,
  });

  final PageController pageController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Text(
            context.loc.participantsLocation,
            style: context.headlineLarge.copyWith(fontWeight: FontWeight.w500),
          ),
          CustomAlignText(text: context.loc.ageGroup),
          CustomDropdownField(
            hintText: context.loc.selectOne,
            // value: selectedEventType.value,
            fillColor: AppColors.softBrandColor,
            validator: TextFieldValidator.required(context),
            items: const ["Any Age", "5–7 years", "8–10 years", "11–13 years", "14–16 years", "17+ years"],
            onChanged: (value) {

            },
          ),
          CustomAlignText(text: context.loc.skillLevel),
          CustomDropdownField(
            hintText: context.loc.selectOne,
            // value: selectedEventType.value,
            fillColor: AppColors.softBrandColor,
            validator: TextFieldValidator.required(context),
            items: const ["All Types", "Intermediate", "Beginner", "Advanced"],
            onChanged: (value) {

            },
          ),
          CustomTextField(
            title: context.loc.available_slot,
            hintText: context.loc.available_slot,
            // controller: eventPhoneNumber,
            validator: TextFieldValidator.required(context),
          ),
          CustomTextField(
            title: context.loc.zipCode,
            hintText: context.loc.zipCode,
            // controller: eventPhoneNumber,
            validator: TextFieldValidator.required(context),
          ),
          CustomTextField(
            title: context.loc.locationNameVenue,
            hintText: "****",
            // controller: eventPhoneNumber,
            validator: TextFieldValidator.required(context),
          ),
          CustomTextField(
            title: context.loc.cityState,
            hintText: "****",
            // controller: eventPhoneNumber,
            validator: TextFieldValidator.required(context),
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
}
