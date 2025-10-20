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
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.softBrandColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ValueListenableBuilder(
                valueListenable: selectedImage,
                builder: (context, imagePath, child) {
                  if (imagePath != null && imagePath.isNotEmpty) {
                    return Image.file(File(imagePath));
                  }
                  return Column(
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
            hintText: context.loc.eventName,
            controller: eventName,
            validator: TextFieldValidator.required(context),
          ),
          CustomTextField(
            title: context.loc.eventShortDescription,
            hintText: context.loc.eventShortDescription,
            controller: eventDescription,
            validator: TextFieldValidator.required(context),
          ),
          CustomTextField(
            title: context.loc.phoneNumber,
            hintText: context.loc.phoneNumber,
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
                return Center(child: Text(state.message));
              }

              if (state is CategoryLoaded && state.categories.isNotEmpty) {
                final displayItems = state.categories.toList();
                final itemList = displayItems
                    .map((item) => item["name"] ?? "")
                    .where((name) => name.isNotEmpty)
                    .toSet()
                    .toList();
                return CustomDropdownField(
                  hintText: context.loc.selectOne,
                  fillColor: AppColors.softBrandColor,
                  value: selectedSportType.value,
                  items: itemList,
                  validator: TextFieldValidator.required(context),
                  onChanged: (value) {
                    selectedSportType.value = value;
                  },
                );
              }
              return Center(child: Text(context.loc.no_categories_found));
            },
          ),
          CustomAlignText(text: context.loc.eventType),
          ValueListenableBuilder(
            valueListenable: selectedEventType,
            builder: (context, item, child){
              return CustomDropdownField(
                hintText: context.loc.selectOne,
                value: item,
                fillColor: AppColors.softBrandColor,
                validator: TextFieldValidator.required(context),
                items: const ["Registration Open", "Event Started", "Event Finished"],
                onChanged: (value) {
                  selectedEventType.value = value;
                },
              );
            },
          ),
          const Gap(12),
          CustomButton(
            text: context.loc.next,
            onTap: () {
              if(formKey.currentState!.validate()){
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
