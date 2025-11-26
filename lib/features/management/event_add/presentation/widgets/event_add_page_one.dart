import 'dart:io';

import 'package:event_listing_app/app_export.dart';

class EventAddPageOne extends StatelessWidget {
  const EventAddPageOne({
    super.key,
    required this.pageController,
    required this.formKey,

    required this.eventName,
    required this.eventDescription,
    required this.eventPhoneNumber,

    required this.selectedImage,
    required this.selectedSportType,
    required this.selectedEventType,
  });

  final PageController pageController;
  final GlobalKey<FormState> formKey;

  final ValueNotifier<String?> selectedImage;
  final ValueNotifier<String?> selectedSportType;
  final ValueNotifier<String?> selectedEventType;

  final TextEditingController eventName;
  final TextEditingController eventDescription;
  final TextEditingController eventPhoneNumber;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Text(
            context.loc.eventBasics,
            style: context.headlineLarge.copyWith(fontWeight: FontWeight.w500),
          ),
          const Gap(12),
          Text(
            context.loc.eventPhotos,
            style: context.titleSmall.copyWith(fontWeight: FontWeight.w500),
          ),
          GestureDetector(
            onTap: () async {
              try {
                final imagePath = await pickImage();
                if (imagePath != null && imagePath.isNotEmpty) {
                  selectedImage.value = imagePath;
                }
              } catch (_) {}
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              height: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.softBrandColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ValueListenableBuilder(
                valueListenable: selectedImage,
                builder: (context, imagePath, child) {
                  if (imagePath != null && imagePath.isNotEmpty) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(File(imagePath), fit: BoxFit.cover,),
                    );
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 12,
                    children: [
                      Assets.icons.upload.svg(height: 50, width: 50),
                      Text(
                        context.loc.uploadImages,
                        style: context.bodyLarge.copyWith(fontWeight: FontWeight.w400),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          CustomTextField(
            title: context.loc.eventName,
            hintText: "e.g., Summer Elite Soccer Camp 2025",
            controller: eventName,
            validator: TextFieldValidator.required(context),
          ),
          CustomTextField(
            title: context.loc.eventShortDescription,
            hintText: "e.g., A 3-day intensive camp for players aged 10–14, focusing on skills, tactics, and small-sided games.",
            controller: eventDescription,
            validator: TextFieldValidator.required(context),
          ),
          CustomTextField(
            title: context.loc.phoneNumber,
            hintText: "e.g. (480) 555-0103",
            controller: eventPhoneNumber,
            validator: TextFieldValidator.required(context),
          ),
          CustomAlignText(text: context.loc.sport),
          BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return const LoadingWidget();
              }

              if (state is CategoryError) {
                return ErrorCard(onTap: () {  }, text: state.message,);
              }

              if (state is CategoryLoaded && state.categories.getSports().isNotEmpty) {
                final displayItems = state.categories.getSports().toList();

                final selectedEntity = displayItems.cast<CategoryEntities?>().firstWhere(
                      (e) => e?.id == selectedSportType.value,
                  orElse: () => null,
                );

                return CustomDropdownField<CategoryEntities>(
                  hintText: context.loc.selectOne,
                  fillColor: AppColors.softBrandColor,
                  items: displayItems,
                  labelBuilder: (s) => s.name,
                  value: selectedEntity,
                  isRequired: true,
                  onChanged: (value) {
                    selectedSportType.value = value?.id;
                  },
                );
              }
              return const NoDataCard(
                text: "Category will appear once they’re available.",
              );
            },
          ),
          CustomAlignText(text: context.loc.eventType),
          BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return const LoadingWidget();
              }

              if (state is CategoryError) {
                return ErrorCard(onTap: () {  }, text: state.message,);
              }

              if (state is CategoryLoaded && state.categories.getSports().isNotEmpty) {
                final displayItems = state.categories.getEvents().toList();

                final selectedEntity = displayItems.cast<CategoryEntities?>().firstWhere(
                      (e) => e?.id == selectedEventType.value,
                  orElse: () => null,
                );

                return CustomDropdownField<CategoryEntities>(
                  hintText: context.loc.selectOne,
                  fillColor: AppColors.softBrandColor,
                  labelBuilder: (s) => s.name,
                  items: displayItems,
                  value: selectedEntity,
                  isRequired: true,
                  onChanged: (value) {
                    selectedEventType.value = value?.id;
                  },
                );
              }
              return const NoDataCard(
                text: "Event will appear once they’re available.",
              );
            },
          ),
          const Gap(12),
          CustomButton(
            text: context.loc.next,
            onTap: () {
              if (formKey.currentState!.validate()) {
                if (selectedImage.value == null || selectedImage.value!.isEmpty) {
                  AppToast.warning(
                    message: context.loc.pleaseUploadImage,
                  );
                  return;
                }
                pageController.nextPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
