import 'package:event_listing_app/app_export.dart';

class SearchDrawer extends StatelessWidget {
  const SearchDrawer({super.key, required this.controller});
  final SearchScreenCubit controller;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.softBrandColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            spacing: 8,
            children: [
              CustomTextField(
                fillColor: AppColors.white,
                title: context.loc.location,
                hintText: context.loc.location_ZIP_Code_or_City,
              ),
              CustomAlignText(text: context.loc.sport),
              CustomDropdownField(
                hintText: context.loc.selectOne,
                items: const [
                  "Registration Open",
                  "Event Started",
                  "Event Finished"
                ],
                onChanged: (value){
        
                },
              ),
              CustomAlignText(text: context.loc.ageGroup),
              CustomDropdownField(
                hintText: context.loc.selectOne,
                items: const [
                  "Registration Open",
                  "Event Started",
                  "Event Finished"
                ],
                onChanged: (value){

                },
              ),
              CustomAlignText(text: context.loc.eventType),
              CustomDropdownField(
                hintText: context.loc.selectOne,
                items: const [
                  "Registration Open",
                  "Event Started",
                  "Event Finished"
                ],
                onChanged: (value){

                },
              ),
              CustomAlignText(text: context.loc.skillLevel),
              CustomDropdownField(
                hintText: context.loc.selectOne,
                items: const [
                  "Registration Open",
                  "Event Started",
                  "Event Finished"
                ],
                onChanged: (value){

                },
              ),
              CustomAlignText(text: context.loc.dateRange),
              CustomDropdownField(
                hintText: context.loc.selectOne,
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
                text: context.loc.apply_filter,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
