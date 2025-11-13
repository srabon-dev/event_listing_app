import 'package:event_listing_app/app_export.dart';
import 'package:flutter/services.dart';

class EventAddPageThree extends StatelessWidget {
  const EventAddPageThree({
    super.key,
    required this.pageController,
    required this.formKey,
    required this.selectedAgesGroup,
    required this.selectedSkillLevel,
    required this.availableSlot,
    required this.zipCode,
    required this.location,
    required this.city,
  });

  final PageController pageController;
  final GlobalKey<FormState> formKey;

  final ValueNotifier<String?> selectedAgesGroup;
  final ValueNotifier<String?> selectedSkillLevel;
  final TextEditingController availableSlot;
  final TextEditingController zipCode;
  final ValueNotifier<PickedLocation?> location;
  final TextEditingController city;

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
            value: selectedAgesGroup.value,
            fillColor: AppColors.softBrandColor,
            validator: TextFieldValidator.required(context),
            items: const [
              "Any Age",
              "5–7 years",
              "8–10 years",
              "11–13 years",
              "14–16 years",
              "17+ years",
            ],
            onChanged: (value) {
              if(value != null){
                selectedAgesGroup.value = value;
              }
            },
          ),
          CustomAlignText(text: context.loc.skillLevel),
          CustomDropdownField(
            hintText: context.loc.selectOne,
            value: selectedSkillLevel.value,
            fillColor: AppColors.softBrandColor,
            validator: TextFieldValidator.required(context),
            items: const ["Intermediate", "Beginner", "Advanced"],
            onChanged: (value) {
              if(value != null){
                selectedSkillLevel.value = value;
              }
            },
          ),
          CustomTextField(
            title: context.loc.available_slot,
            hintText: context.loc.available_slot,
            controller: availableSlot,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: TextFieldValidator.required(context),
          ),
          CustomTextField(
            title: context.loc.zipCode,
            hintText: context.loc.enterZipCode,
            controller: zipCode,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: TextFieldValidator.required(context),
          ),
          ValueListenableBuilder(
            valueListenable: location,
            builder: (_, item, _){
              return _BoxLocationCard(
                title: context.loc.locationNameVenue,
                name: item?.address ?? context.loc.enterLocationNameVenue,
                onTap: () async {
                  location.value = await openLocationPicker(context);
                  print(location.value?.address);
                },
              );
            },
          ),
          CustomTextField(
            title: context.loc.cityState,
            hintText: context.loc.enterCityState,
            controller: city,
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

                      if (selectedAgesGroup.value == null || selectedAgesGroup.value!.isEmpty) {
                        AppToast.warning(message: context.loc.pleaseSelectAgeGroup);
                        return;
                      }

                      if (selectedSkillLevel.value == null || selectedSkillLevel.value!.isEmpty) {
                        AppToast.warning(message: context.loc.pleaseSelectSkillLevel);
                        return;
                      }

                      if (location.value == null) {
                        AppToast.warning(message: context.loc.enterLocationNameVenue);
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
}

class _BoxLocationCard extends StatelessWidget {
  const _BoxLocationCard({required this.name, required this.title, this.onTap});

  final String title;
  final String name;
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
            width: context.width,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.softBrandColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(name),
          ),
        ),
      ],
    );
  }
}
