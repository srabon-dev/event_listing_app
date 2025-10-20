import 'package:event_listing_app/app_export.dart';

class EventAddPageFour extends StatelessWidget {
  const EventAddPageFour({super.key});

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
            style: context.headlineMedium.copyWith(fontWeight: FontWeight.w500),
          ),
          const Gap(12),
          Text(
            context.loc.eventPhotos,
            style: context.titleSmall.copyWith(fontWeight: FontWeight.w500),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.softBrandColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              spacing: 12,
              children: [
                Assets.icons.upload.svg(height: 50, width: 50),
                Text(
                  context.loc.uploadImages,
                  style: context.bodyLarge.copyWith(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          CustomTextField(
            title: context.loc.eventName,
            hintText: context.loc.eventName,
          ),
          CustomTextField(
            title: context.loc.eventShortDescription,
            hintText: context.loc.eventShortDescription,
          ),
          CustomTextField(
            title: context.loc.phoneNumber,
            hintText: context.loc.phoneNumber,
          ),
          CustomAlignText(text: context.loc.sport),
          CustomDropdownField(
            hintText: context.loc.selectOne,
            fillColor: AppColors.softBrandColor,
            items: const [
              "Registration Open",
              "Event Started",
              "Event Finished"
            ],
            onChanged: (value) {

            },
          ),
          CustomAlignText(text: context.loc.eventType),
          CustomDropdownField(
            hintText: context.loc.selectOne,
            fillColor: AppColors.softBrandColor,
            items: const [
              "Registration Open",
              "Event Started",
              "Event Finished"
            ],
            onChanged: (value){

            },
          ),
          const Gap(12),
          CustomButton(
            text: context.loc.next,
            onTap: (){},
          ),
        ],
      ),
    );
  }
}
